require 'spec_helper'

describe Restaurant, type: :model do
  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to(have(1).error_on(:name))
    expect(restaurant).not_to(be_valid)
  end

  it 'is not valid unless is has a unique name' do
    restaurant_two = Restaurant.create(name: "Moe's Tavern")
    restaurant = Restaurant.create(name: "Moe's Tavern")
    restaurant_two.save(:validate => false)
    expect(restaurant).to(have(1).error_on(:name))
  end

  describe 'reviews' do
    describe 'build_with_user' do

      let(:user) { User.create email: 'test@test.com' }
      let(:restaurant) { Restaurant.create name: 'Test' }
      let(:review_params) { {rating: 5, thoughts: 'yum'} }

      subject(:review) { restaurant.reviews.build_with_user(review_params, user) }

      it 'builds a review' do
        expect(review).to be_a Review
      end

      it 'builds a review associated with the specified user' do
        expect(review.user).to eq user
      end
    end
  end

  describe '#average_rating' do

    context 'no reviews' do
      it 'returns "N/A" when there are no reviews' do
        restaurant = Restaurant.create(name: 'The Ivy')
        expect(restaurant.average_rating).to eq 'N/A'
      end
    end

    context 'one review' do
      it 'returns that rating' do
        restaurant = Restaurant.create(name: 'The Ivy')
        restaurant.save(validate: false)
        review = restaurant.reviews.create(rating: 4)
        review.save(validate: false)
        expect(restaurant.average_rating).to eq 4
      end
    end

    context 'multiple reviews' do
      it 'returns the average' do
        restaurant = Restaurant.create(name: 'The Ivy')
        restaurant.save(validate: false)
        review1 = restaurant.reviews.create(rating: 1)
        review1.save(validate: false)
        review2 = restaurant.reviews.create(rating: 5)
        review2.save(validate: false)
        expect(restaurant.average_rating).to eq 3
      end
    end

  end

end
