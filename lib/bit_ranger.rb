require "bit_ranger/version"

module BitRanger
  class << self
    def settings
      {test1: 0, test2: 1, test3: 3}.freeze
    end

    def toggle(flags, setting)
      flags ^ bitmask_for(setting)
    end

    def enable(flags, setting)
      flags | bitmask_for(setting)
    end

    def disable(flags, setting)
      flags & ~bitmask_for(setting)
    end

    def list(flags)
      settings
        .keys
        .select do |k|
          enabled?(flags, k)
        end
        .map(&:to_s)
        .sort
    end

    def enabled?(flags, setting)
      (flags & bitmask_for(setting)).positive?
    end

    private

    def bitmask_for(setting)
      (1 << settings[setting.to_sym])
    end
  end
end
