# frozen_string_literal: true
require 'spec_helper'
require 'hako/yaml_loader'

RSpec.describe Hako::YamlLoader do
  let(:yaml_loader) { described_class.new }

  describe '#load' do
    it 'loads YAML file' do
      expect(yaml_loader.load(fixture_root.join('yaml', 'simple.yml'))).to eq(
        'scheduler' => {
          'type' => 'ecs',
        },
      )
    end

    it 'recognize !include tag' do
      expect(yaml_loader.load(fixture_root.join('yaml', 'include.yml'))).to eq(
        'scheduler' => {
          'type' => 'ecs',
        },
        'app' => {
          'image' => 'nginx',
        },
      )
    end

    it 'recognize SHOVEL (<<) with !include tag' do
      expect(yaml_loader.load(fixture_root.join('yaml', 'shovel.yml'))).to eq(
        'scheduler' => {
          'type' => 'ecs',
          'desired_count' => 1,
        },
        'app' => {
          'image' => 'nginx',
        },
      )
    end
  end
end
