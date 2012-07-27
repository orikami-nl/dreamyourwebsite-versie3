class Solve360::Bsc < ActiveResource::Base
  	self.site = "https://secure.solve360.com/report/opportunities"
	self.user = "andres@dreamyourweb.nl"
	self.password = "rf665e14r7R5T3J5k5GcH077=cc6f5n3V7=8D5fd"
	self.element_name = ""

	class << self
    def element_path(id, prefix_options = {}, query_options = nil)
      prefix_options, query_options = split_options(prefix_options) if query_options.nil?
      "#{prefix(prefix_options)}#{collection_name}/#{id}#{query_string(query_options)}"
    end

    def collection_path(prefix_options = {}, query_options = nil)
      prefix_options, query_options = split_options(prefix_options) if query_options.nil?
      "#{prefix(prefix_options)}#{collection_name}#{query_string(query_options)}"
    end
  end

end
