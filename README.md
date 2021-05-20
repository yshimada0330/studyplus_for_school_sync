# StudyplusForSchoolSync

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'studyplus_for_school_sync', github: 'yshimada0330/studyplus_for_school_sync'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install studyplus_for_school_sync

## Usage

### Authorization

Redirect Server Start

```ruby
StudyplusForSchoolSync::Server.new.start(port: "8080")
```

Retrieve Authorization Code

```ruby
StudyplusForSchoolSync::Authorizer.new(client_id: ENV["CLIENT_ID"], redirect_uri: "https://localhost:8080").authorize
```

Create/Refresh Token

```ruby
authorization_code = "xxx" # Retrieve Authorization Code
token = StudyplusForSchoolSync::Token.new(base_url: ENV["BASE_URL"], client_id: ENV["CLIENT_ID"], client_secret: ENV["CLIENT_SECRET"])
response = token.create(authorization_code: authorization_code, redirect_uri: "https://localhost:8080")
response_body = JSON.parse(response.body) # => {"access_token"=>"xxxx", "token_type"=>"Bearer", "expires_in"=>86399, "refresh_token"=>"xxx", "scope"=>"learning_material_supplier lms_passcode_issue", "created_at"=>1621398508}

response = token.refresh(response_body["refresh_token"])
response_body = JSON.parse(response.body) # => {"access_token"=>"xxx", "token_type"=>"Bearer", "expires_in"=>86399, "refresh_token"=>"xxx", "scope"=>"learning_material_supplier lms_passcode_issue", "created_at"=>1621398923}
```

### Resource Access

```ruby
client = StudyplusForSchoolSync::Client.new(base_url: ENV["BASE_URL"], access_token: response_body["access_token"])
response = client.create_partner(school_name: "school A")
response.status # => 200
response.body # => {"public_id"=>"12345abcde"}

response = client.create_student(
  partner_public_id: response.body["public_id"],
  last_name: "山田",
  first_name: "太郎",
  last_name_kana: "ヤマダ",
  first_name_kana: "タロウ"
)
student_public_id = response.body["public_id"]

response = client.create_learning_material(name: "text A")
learning_material_public_id = response.body["public_id"]
response = client.update_learning_material(learning_material_public_id: learning_material_public_id, name: "text B")

response = client.create_study_record(
  learning_material_public_id: learning_material_public_id,
  student_public_id: student_public_id,
  recorded_at: "2020/03/01 09:30:10",
  number_of_seconds: 600
)

response = client.create_passcode(student_public_id)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yshimada0330/studyplus_for_school_sync. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the StudyplusForSchoolSync project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/yshimada0330/studyplus_for_school_sync/blob/master/CODE_OF_CONDUCT.md).
