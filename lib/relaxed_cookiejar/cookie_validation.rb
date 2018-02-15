require 'cookiejar'


module RelaxedCookieJar
  module CookieValidation

    def self.included(base)
      base.extend(ClassMethods)

      base.module_eval do
        # This was the only way I found that would reliably override a static
        # method defined on a module, otherwise the old method was called.
        #
        # If you have a better idea of doing this, please create a PR.
        singleton_class.send :alias_method,
                             :compute_search_domains_for_host_with_no_recursion,
                             :compute_search_domains_for_host

        singleton_class.send :alias_method,
                             :compute_search_domains_for_host,
                             :compute_search_domains_for_host_with_recursion
      end
    end

    module ClassMethods

      def compute_search_domains_for_host_with_recursion(host)
        host   = effective_host host
        result = [host]

        if host =~ CookieJar::CookieValidation::IPADDR
          result
        else
          result + recursive_search_domain(host)
        end
      end

      def recursive_search_domain(host)
        m = CookieJar::CookieValidation::BASE_HOSTNAME.match(host)

        result = [".#{host}"]

        if m.nil?
          result
        else
          result + recursive_search_domain(m[1])
        end
      end
    end
  end
end

# The actual monkeypatching.
CookieJar::CookieValidation.include RelaxedCookieJar::CookieValidation
