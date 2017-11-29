require "test_helper"

describe BitRanger do
  Given(:user) do
    Struct.new(:settings).new(0)
  end

  context "version number exists" do
    Then { !BitRanger::VERSION.nil? }
  end

  context "starts at zero" do
    Then { user.settings == 0 }
  end

  context "#toggle" do
    BitRanger.settings.each_pair do |k, v|
      context "flag at bit #{v}" do
        When { BitRanger.toggle(user, k) }
        Then { user.settings == 2**v }
      end
    end
  end

  context "#list" do
    Given(:sum) { BitRanger.settings.values.sum{|i| 2**i } }

    When { user.settings = sum }
    Then { BitRanger.list(user) == BitRanger.settings.keys.map(&:to_s).sort }
  end

  context "#enabled?" do
    Given(:enabled_flag)  { BitRanger.settings.keys.sample }
    Given(:disabled_flag) { (BitRanger.settings.keys - [enabled_flag]).sample }

    When { user.settings = 2**BitRanger.settings[enabled_flag] }

    context "for an enabled flag" do
      Then { BitRanger.enabled?(user, enabled_flag) }
    end

    context "for a disabled flag" do
      Then { !BitRanger.enabled?(user, disabled_flag) }
    end
  end

  context "#enable" do
    Given(:flag)  { BitRanger.settings.keys.sample }
    Given(:enabled_value) { 2**BitRanger.settings[flag] }

    context "no previous flags enabled" do
      When { BitRanger.enable(user, flag) }

      Then { BitRanger.enabled?(user, flag) }
      And  { user.settings == enabled_value }

      context "same flag enabled again" do
        When { BitRanger.enable(user, flag) }

        Then { BitRanger.enabled?(user, flag) }
        And  { user.settings == enabled_value }
      end
    end

    context "a different flag was enabled" do
      Given(:other_flag) { (BitRanger.settings.keys - [flag]).sample }
      Given { BitRanger.enable(user, other_flag) }

      When { BitRanger.enable(user, flag) }

      Then { BitRanger.enabled?(user, flag) }
      And  { user.settings > enabled_value }
    end
  end

  context "#disable" do
    Given(:flag)  { BitRanger.settings.keys.sample }

    context "no previous flags enabled" do
      When { BitRanger.disable(user, flag) }

      Then { !BitRanger.enabled?(user, flag) }
      And  { user.settings == 0 }
    end

    context "flag was enabled" do
      Given { BitRanger.enable(user, flag) }
      When { BitRanger.disable(user, flag) }

      Then { !BitRanger.enabled?(user, flag) }
      And  { user.settings == 0 }
    end

    context "a different flag was enabled" do
      Given(:other_flag) { (BitRanger.settings.keys - [flag]).sample }
      Given { BitRanger.enable(user, other_flag) }

      When { BitRanger.disable(user, flag) }

      Then { !BitRanger.enabled?(user, flag) }
      And  { BitRanger.enabled?(user, other_flag) }

      context "both flags were enabled" do
        Given(:other_flag) { (BitRanger.settings.keys - [flag]).sample }
        Given { BitRanger.enable(user, other_flag) }

        When { BitRanger.disable(user, flag) }

        Then { !BitRanger.enabled?(user, flag) }
        And  { BitRanger.enabled?(user, other_flag) }
      end
    end
  end
end
