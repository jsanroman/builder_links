require 'spec_helper'

describe BuilderLinks do
  before :each do
    @text = %{
      <p>I wanted to illuminate the whole earth. There is enough electricity to become a second sun.</p>
      <p>Light would appear around the equator, as a ring around Saturn.Mankind is not ready for the great and good.</p>
      <p>In <strong>Colorado Springs</strong> I soaked the earth by electricity </p>
    }

    BuilderLinks.patterns = [
      {keyword: "I wanted to illuminate the whole earth", link: 'http://www.freedomtek.org/en/texts/nikola_tesla_interview_1899.php'},
      {keyword: "electricity", link: 'https://en.wikipedia.org/wiki/Electricity'}
    ]
    BuilderLinks.total_links = 10
    BuilderLinks.keyword_links = 5
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
    BuilderLinks.keyword_links = 2
    text = BuilderLinks::Analize.new(@text).run

    expect(Nokogiri::HTML(text).css('a').size).to eq(3)

    BuilderLinks.keyword_links = 1
    text = BuilderLinks::Analize.new(@text).run

    expect(Nokogiri::HTML(text).css('a').size).to eq(2)
  end

  it 'replace text in strong tag is success' do
    BuilderLinks.patterns = [{keyword: 'Colorado Springs', link: 'https://es.wikipedia.org/wiki/Colorado_Springs_(Colorado)'}]

    text = BuilderLinks::Analize.new(@text).run
    expect(Nokogiri::HTML(text).css('a').size).to eq(1)
  end

  it 'no replace text between tags' do
    BuilderLinks.patterns = [{keyword: 'In Colorado Springs', link: 'https://es.wikipedia.org/wiki/Colorado_Springs_(Colorado)'}]

    text = BuilderLinks::Analize.new(@text).run
    expect(Nokogiri::HTML(text).css('a').size).to eq(0)
  end
end
