require 'swagger_helper'

describe 'Article Categories', type: :request do
  include ApiHelper

  path '/article_categories' do
    get 'article categories' do
      tags 'Category'
      produces 'application/json'
      parameter name: "per_page", in: :query, type: :integer, required: false
      parameter name: "page", in: :query, type: :integer, required: false
      let(:order_article) { create(:order, article_count: 1).order_articles.first }
      let(:stock_article) { create(:stock_article) }
      let(:stock_order_article) { create(:stock_order, article_ids: [stock_article.id]).order_articles.first }

      response '200', 'success' do
        schema type: :object, properties: {
          article_categories: {
            type: :array,
            items: {
              '$ref': '#/components/schemas/ArticleCategory'
            }
          }
        }
        run_test!
      end

      it_handles_invalid_token
    end
  end

  path '/article_categories/{id}' do
    get 'find article category by id' do
      tags 'Category'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'article category found' do
        schema type: :object, properties: {
          article_categories: {
            type: :array,
            items: {
              '$ref': '#/components/schemas/ArticleCategory'
            }
          }
        }
        let(:id) { create(:article_category, name: 'dairy').id }
        run_test!
      end
      it_handles_invalid_token_with_id(:article_category)
      it_cannot_find_object
    end
  end
end
