# encoding: UTF-8

describe Hangry do
  context "cooks.com recipe" do
    before(:all) do
      @html = File.read("spec/fixtures/cooks.com.html").encode!("UTF-8", 'binary', :invalid => :replace, :undef => :replace, :replace => '')
      @parsed = Hangry.parse(@html)
    end
    subject { @parsed }

    it "should use the h-recipe parser" do
      expect(Hangry::ParserSelector.new(@html).parser).to be_an_instance_of(Hangry::HRecipeParser)
    end

    its(:author) { should == "CM" }
    its(:canonical_url) { should == nil }
    its(:cook_time) { should == nil }
    its(:description) { should == nil }
    its(:image_url) { should == 'http://img.cooks.com/i/rec/IMG_0814-200.jpg' }
    its(:ingredients) {
      should == [
        "2 c. flour",
        "1/2 c. powdered sugar",
        "1 packet True Lemon, divided (optional)",
        "1 c. butter",
        "4 eggs, well beaten",
        "2 c. sugar",
        "1/3 c. freshly squeezed lemon juice",
        "2-3 drops pure lemon oil (optional)",
        "1/2 tsp. baking powder",
        "1/4 c. flour",
        "Grated rind of 1 lemon (optional)"
      ]
    }
    its(:name) { should == "LEMON BARS DELUXE" }
    its(:nutrition) do
      should == {
        calories: nil,
        cholesterol: nil,
        fiber: nil,
        protein: nil,
        saturated_fat: nil,
        sodium: nil,
        sugar: nil,
        total_carbohydrates: nil,
        total_fat: nil,
        trans_fat: nil,
        unsaturated_fat: nil
      }
    end

    its(:instructions) {
      instructions = <<-EOS
Mix first 3 ingredients using half of the True Lemon packet (optional). Using a pastry blender or two knives, cut in butter as you would when making pie crust until it resembles coarse crumbs.Press crumb mixture into a 9 x 13 inch pan. Bake in a preheated 350F oven for 15-20 minutes.Combine the remaining ingredients (and the other half of the True Lemon packet) to make the lemon filling.Pour over crust and bake for 25 minutes at 350F or until lightly golden on top. Sprinkle with powdered sugar when cool.Cut into bars.
      EOS
      should == instructions.strip
    }

    its(:prep_time) { should == nil }
    its(:published_date) { should == nil }
    its(:total_time) { should == nil }
    its(:yield) { should == nil }
  end
end
