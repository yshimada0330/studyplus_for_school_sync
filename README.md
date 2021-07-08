# StudyplusForSchoolSync

[![Build Status](https://travis-ci.com/yshimada0330/studyplus_for_school_sync.svg?branch=master)](https://travis-ci.com/yshimada0330/studyplus_for_school_sync)
[![Maintainability](https://api.codeclimate.com/v1/badges/be0e005027ea497a53db/maintainability)](https://codeclimate.com/github/yshimada0330/studyplus_for_school_sync/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/be0e005027ea497a53db/test_coverage)](https://codeclimate.com/github/yshimada0330/studyplus_for_school_sync/test_coverage)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/yshimada0330/studyplus_for_school_sync)
[![Inline docs](https://inch-ci.org/github/yshimada0330/studyplus_for_school_sync.svg?branch=master)](http://inch-ci.org/github/yshimada0330/studyplus_for_school_sync)
![GitHub](https://img.shields.io/github/license/yshimada0330/studyplus_for_school_sync)

A Ruby Client for [Studyplus for School SYNC API](https://studyplus.github.io/fs-sync-api/)

![logo](https://user-images.githubusercontent.com/7440963/124934927-251b3180-e040-11eb-82bf-04cf82021593.jpg)

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

1. Redirect Server Start: Case where the redirect server that receives authorization code is localhost
1. Retrieve Authorization Code:
   1. If you start localhost, run it in a different terminal
   1. Authorize and receive the authorization code on the redirect server.
1. Create/Refresh Token: Creating a token from authorization code

Redirect Server Start:

    $ bundle exec studyplus_for_school_sync server

Retrieve Authorization Code:

    $ bundle exec studyplus_for_school_sync authorize [BASE_URL] [CLIENT_ID]

Create/Refresh Token:

```ruby
authorization_code = "xxx" # Retrieve Authorization Code
token = StudyplusForSchoolSync::Token.new(base_url: ENV["BASE_URL"], client_id: ENV["CLIENT_ID"], client_secret: ENV["CLIENT_SECRET"])
response = token.create(authorization_code: authorization_code, redirect_uri: "https://localhost:8080")
response.status # => 200
response.body # => {"access_token"=>"xxx", "token_type"=>"Bearer", "expires_in"=>86399, "refresh_token"=>"xxxx", "scope"=>"learning_material_supplier lms_passcode_issue", "created_at"=>1621558627}


response = token.refresh(response.body["refresh_token"])
response.status # => 200
response.body # => {"access_token"=>"xxx", "token_type"=>"Bearer", "expires_in"=>86399, "refresh_token"=>"xxx", "scope"=>"learning_material_supplier lms_passcode_issue", "created_at"=>1621558753}
```

### Resource Access

`access_token` is the value obtained from Authorization flow.

```ruby
client = StudyplusForSchoolSync::Client.new(base_url: ENV["BASE_URL"], access_token: access_token)
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
response.status #=> 200
response.body # => {"public_id"=>"xxxx"}
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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yshimada0330/studyplus_for_school_sync. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the StudyplusForSchoolSync project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/yshimada0330/studyplus_for_school_sync/blob/master/CODE_OF_CONDUCT.md).
