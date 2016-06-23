require 'spec_helper'

describe BuilderLinks do
  before :each do
    @text = %{
      <p>I wanted to illuminate the whole earth. There is enough electricity to become a second sun.</p>
      <p>Light would appear around the equator, as a ring around Saturn.Mankind is not ready for the great and good.</p>
      <p>In <strong>Colorado Springs</strong> I soaked the earth by electricity </p>
    }

    BuilderLinks.patterns = [
      {anchortext: "I wanted to illuminate the whole earth", uri: 'https://es.wikipedia.org/wiki/Nikola_Tesla'},
      {anchortext: "electricity", uri: 'https://en.wikipedia.org/wiki/Electricity'}
    ]
    BuilderLinks.total_links = 10
    BuilderLinks.links_per_pattern = 5
  end

  it 'has a version number' do
    expect(BuilderLinks::VERSION).not_to be nil
  end

  it 'reestriction "total links" is success' do
    BuilderLinks.total_links = 3
    text = BuilderLinks::Analize.new(@text).run
    expect(Nokogiri::HTML(text).css('a').size).to eq(3)

    BuilderLinks.total_links = 2
    text = BuilderLinks::Analize.new(@text).run
    expect(Nokogiri::HTML(text).css('a').size).to eq(2)

    BuilderLinks.total_links = 1
    text = BuilderLinks::Analize.new(@text).run
    expect(Nokogiri::HTML(text).css('a').size).to eq(1)
  end

  it 'reestriction "keyword links" is success' do
    BuilderLinks.links_per_pattern = 2
    text = BuilderLinks::Analize.new(@text).run

    expect(Nokogiri::HTML(text).css('a').size).to eq(3)

    BuilderLinks.links_per_pattern = 1
    text = BuilderLinks::Analize.new(@text).run

    expect(Nokogiri::HTML(text).css('a').size).to eq(2)
  end

  it 'replace text in strong tag is success' do
    BuilderLinks.patterns = [{anchortext: 'Colorado Springs', uri: 'https://es.wikipedia.org/wiki/Colorado_Springs_(Colorado)'}]

    text = BuilderLinks::Analize.new(@text).run
    expect(Nokogiri::HTML(text).css('a').size).to eq(1)
  end

  it 'no replace text between tags' do
    BuilderLinks.patterns = [{anchortext: 'In Colorado Springs', uri: 'https://es.wikipedia.org/wiki/Colorado_Springs_(Colorado)'}]

    text = BuilderLinks::Analize.new(@text).run
    expect(Nokogiri::HTML(text).css('a').size).to eq(0)
  end

  it 'no generate link to black uris is success' do
    BuilderLinks.total_links = 1
    text = BuilderLinks::Analize.new(@text, {
      black_uris: ['https://es.wikipedia.org/wiki/Nikola_Tesla', 'https://en.wikipedia.org/wiki/Electricity']
      }).run

    expect(Nokogiri::HTML(text).css('a').size).to eq(0)
  end
end
