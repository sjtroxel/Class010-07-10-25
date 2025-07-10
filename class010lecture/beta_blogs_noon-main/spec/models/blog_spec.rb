require 'rails_helper'

RSpec.describe Blog, type: :model do
  context "Validation tests" do
    it "is not valid without a title" do
      user = User.create(first_name: "John", last_name: "Doe", username: "johndoe", email: "johndoe@email.com")
      blog = Blog.new(content: "Sample content", user: user)
      expect(blog).to_not be_valid
      expect(blog.errors[:title]).to include("can't be blank")  # optional
    end

      it "is not valid without content" do
        user = User.create(first_name: "John", last_name: "Doe", username: "johndoe", email: "johndoe@email.com")
        blog = Blog.new(title: "Sample title", user: user)
        expect(blog).to_not be_valid
        expect(blog.errors[:content]).to include("can't be blank")
  end
end
  context "Association tests" do

  end
end
