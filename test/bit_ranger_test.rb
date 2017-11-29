require "test_helper"

describe BitRanger do
  Given(:described_class) { BitRanger }
  Given(:settings) { 0 }

  context "version number exists" do
    Then { !described_class::VERSION.nil? }
  end

  context "#toggle" do
    BitRanger.settings.each_pair do |k, v|
      context "flag at bit #{v}" do
        Then { described_class.toggle(settings, k) == 2**v }
      end
    end
  end

  context "#list" do
    When(:sum) { described_class.settings.values.sum{|i| 2**i } }

    Then { described_class.list(sum) == described_class.settings.keys.map(&:to_s).sort }
  end

  context "#enabled?" do
    Given(:enabled_flag)  { described_class.settings.keys.sample }
    Given(:disabled_flag) { (described_class.settings.keys - [enabled_flag]).sample }

    When(:settings) { 2**described_class.settings[enabled_flag] }

    context "for an enabled flag" do
      Then { described_class.enabled?(settings, enabled_flag) }
    end

    context "for a disabled flag" do
      Then { !described_class.enabled?(settings, disabled_flag) }
    end
  end

  context "#enable" do
    Given(:flag)  { described_class.settings.keys.sample }
    Given(:enabled_value) { 2**described_class.settings[flag] }

    context "no previous flags enabled" do
      When(:settings) { described_class.enable(0, flag) }

      Then { described_class.enabled?(settings, flag) }
      And  { settings == enabled_value }

      context "same flag enabled again" do
        When(:enabled_again) { described_class.enable(settings, flag) }

        Then { described_class.enabled?(enabled_again, flag) }
        And  { enabled_again == enabled_value }
      end
    end

    context "a different flag was enabled" do
      Given(:other_flag)  { (described_class.settings.keys - [flag]).sample }
      Given(:settings)    { described_class.enable(0, other_flag) }

      When(:flag_enabled) { described_class.enable(settings, flag) }

      Then { described_class.enabled?(flag_enabled, flag) }
      And  { flag_enabled > enabled_value }
    end
  end

  context "#disable" do
    Given(:flag)  { described_class.settings.keys.sample }

    context "no previous flags enabled" do
      When(:settings) { described_class.disable(0, flag) }

      Then { !described_class.enabled?(settings, flag) }
      And  { settings == 0 }
    end

    context "flag was enabled" do
      Given(:settings)  { described_class.enable(0, flag) }
      When(:disabled)   { described_class.disable(settings, flag) }

      Then { !described_class.enabled?(disabled, flag) }
      And  { disabled == 0 }
    end

    context "a different flag was enabled" do
      Given(:other_flag) { (described_class.settings.keys - [flag]).sample }
      Given(:settings) { described_class.enable(0, other_flag) }

      When(:disabled) { described_class.disable(settings, flag) }
      Then { !described_class.enabled?(disabled, flag) }
      And  { described_class.enabled?(disabled, other_flag) }

      context "both flags were enabled" do
        Given(:other_flag) { (described_class.settings.keys - [flag]).sample }
        Given(:settings) { described_class.enable(described_class.enable(0, other_flag), flag) }

        When(:disabled) { described_class.disable(settings, flag) }
        Then { !described_class.enabled?(disabled, flag) }
        And  { described_class.enabled?(disabled, other_flag) }
      end
    end
  end
end
