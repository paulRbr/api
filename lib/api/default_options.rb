module Api

  # Module to include in Default modules of your API toolkit
  module DefaultOptions

    # Configuration options
    # @return [Hash]
    def options
      Hash[Api::Configurable.keys.select { |key| respond_to?(key) }
               .map { |key| [key, send(key)] }]
    end

  end
end
