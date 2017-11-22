###유저를 admin, regular로 나누기
~~~shell
    rails g migration add_role_to_users role:string
    rake db:migrate
~~~
user.rb에 admin인지 확인하는 함수 추가

~~~ruby
    rails c

    User.create(email: "admin@asdf.com", password: "123123", password_confirmation: "123123", role: "admin")

    User.create(email: "regular@asdf.com", password: "123123", password_confirmation: "123123", role: "regular")
~~~    


>보안에 좋은 앱은...블랙리스트보다는 화이트리스트로

authentication & authorization가 중요하다
~~~shell
    # gem cancacn이후
    bundle
    rails g cancan:ability
    #ability.rb파일 수정
    #controller 파일에 load_and_authorize_resource추가
~~~

###heroku 배포
~~~shell
    brew install libpq
    brew install postgresql
    #gem install pg -v '0.21.0'
    bundle install --without production
    git add .
    git commit -m "change heroku"
    heroku create
    git push heroku master
    heroku run rake db:migrate
~~~
