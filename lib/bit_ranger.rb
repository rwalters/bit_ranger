require "bit_ranger/version"

module BitRanger
  class << self
    def settings
      {test1: 0, test2: 1, test3: 3}.freeze
    end

    def toggle(user, setting)
      user.settings ^= (1 << settings[setting.to_sym])
    end

    def enable(user, setting)
      user.settings |= (1 << settings[setting.to_sym])
    end

    def disable(user, setting)
      user.settings &= ~(1 << settings[setting.to_sym])
    end

    def list(user)
      settings
        .keys
        .select do |k|
          enabled?(user, k)
        end
        .map(&:to_s)
        .sort
    end

    def enabled?(user, setting)
      (user.settings & bitmask_for(setting)).positive?
    end

    private

    def bitmask_for(setting)
      (1 << settings[setting])
    end
  end
end
