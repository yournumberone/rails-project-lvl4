# frozen_string_literal: true

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @response = file_fixture('response.json').read
    @headers = {
      Authorization: '*',
      Accept: 'application/vnd.github.v3+json',
      'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Content-Type': 'application/json',
      'User-Agent': 'Octokit Ruby Gem 4.23.0'
    }
  end

  test 'get index' do
    get repositories_url

    assert_response :success
  end

  test 'get new' do
    get new_repository_url
    assert_response :success
  end

  test 'create repository' do
    github_id = JSON.parse(@response)['id']
    post repositories_url, params: { repository: { github_id: github_id } }
    repository = Repository.find_by(github_id: github_id)

    assert_redirected_to repository_url(repository)
    assert { [repository.language, repository.full_name] == ['Ruby', 'yournumberone/rails-project-lvl2'] }
  end

  test 'destroy repository' do
    repository = repositories(:one)
    delete repository_url(repository)
    assert_not(Repository.exists?(repository.id))

    assert_redirected_to repositories_url
  end
end
