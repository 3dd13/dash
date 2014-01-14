module DashboardsHelper
  def format_address(addr)
    addr.gsub(/,?\s*[Hh](ong )*[Kk](ong)*$/,'')
  end
end
