require 'spec_helper'

RSpec.describe Codeme::Config do

  it "accept SHARED_CONFIG as config" do
    expect(subject.accept?(Codeme::Config::SHARED_CONFIG.first)).to be  true
  end

  it "can add new config" do
    subject.register(:new_config)
    expect(subject.accept?(:new_config)).to be true
  end

  it "can set SHARED_CONFIG: auth_type" do
    subject.auth_type = true
    expect(subject.auth_type).to be true
  end

  it "cannot set unregister config" do
    subject.unregister = true
    expect(subject.unregister).to be nil
  end

  it "can set config by method" do
    subject.auth_type true
    expect(subject.auth_type).to be true
  end

  it "can set config by block" do
    subject.auth_type { true }
    expect(subject.auth_type).to be true
  end

  it "can access config when use block" do
    token = SecureRandom.hex(8)
    expect(subject).to receive(:token).with(token)
    subject.auth_type do |config|
      config.token token
      true
    end

    expect(subject.auth_type).to be true
  end

end