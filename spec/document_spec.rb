require "spec_helper"

describe SolrEad::Document do

  before(:all) do
    Solrizer.default_field_mapper = EadMapper.new
    @ex1 = SolrEad::Document.from_xml(fixture "ARC-0005.xml")
    @ex2 = SolrEad::Document.from_xml(fixture "pp002010.xml")
    @ex3 = SolrEad::Document.from_xml(fixture "ARC-0161.xml")
    @solr_ex1 = @ex1.to_solr
    @solr_ex2 = @ex2.to_solr
    @solr_ex3 = @ex3.to_solr
  end

  describe "#terminology" do

    it "should have an id field" do
      @ex1.eadid.first.should == "ARC-0005"
    end

    it "should have a simple title" do
      @ex1.title.first.should match "Eddie Cochran Historical Organization Collection"
    end

    it "should have some subject headings" do
      @ex1.persname.should  include "Cochran, Eddie, 1938-1960"
      @ex1.genreform.should include "Newspapers"
      @ex1.subject.should   include "Rockabilly music"
      @ex2.corpname.should  include "Tuskegee Normal and Industrial Institute--1880-1940."
      @ex2.genreform.should include "Group portraits--1880-1940."
      @ex2.geogname.should  include "Washington, D.C."
      @ex2.name.should      include "Bell, J.S., Portland, OR"
      @ex2.persname.should  include "Johnston, Frances Benjamin, 1864-1952, photographer."
      @ex2.subject.should   include "Buildings--1880-1940."
    end

    it "should have scope and contents" do
      @ex2.scopecontent.first.should match /^Photographs/
    end

    it "should have one separatedmaterial material note from the archdesc section" do
      @ex1.separatedmaterial.first.should match /^Commercially-released publications.*materials are available.$/
    end

    it "should have its xml" do
      @ex1.to_xml.should match "<c\s"
      @ex2.to_xml.should match "<c01\s"\
    end

    it "should have a bibliography" do
      @ex3.bibliography.first.should == "All Music Guide. Accessed February 4, 2013. http://www.allmusic.com/."
    end

  end

  describe ".to_solr" do

    it "should have the appropriate id fields" do
      @solr_ex1["ead_id"].should  == "ARC-0005"
      @solr_ex1["id"].should      == "ARC-0005"
      @solr_ex2["ead_id"].should  == "http://hdl.loc.gov/loc.pnp/eadpnp.pp002010"
      @solr_ex2["id"].should      == "http://hdl.loc.gov/loc.pnp/eadpnp.pp002010"

    end

    it "should have faceted terms created from subject headings" do
      @solr_ex1["persname_facet"].should include "Cochran, Eddie, 1938-1960"
      @solr_ex1["genreform_facet"].should include "Newspapers"
      @solr_ex1["subject_facet"].should include "Rockabilly music"
      @solr_ex2["corpname_facet"].should include "Tuskegee Normal and Industrial Institute--1880-1940."
      @solr_ex2["genreform_facet"].should include "Group portraits--1880-1940."
      @solr_ex2["geogname_facet"].should include "Washington, D.C."
      @solr_ex2["name_facet"].should include "Bell, J.S., Portland, OR"
      @solr_ex2["persname_facet"].should include "Johnston, Frances Benjamin, 1864-1952, photographer."
      @solr_ex2["subject_facet"].should include "Buildings--1880-1940."
    end

  end

end