### 유저를 admin, regular로 나누기
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

### heroku 배포
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

### 게시판
~~~shell
    rails g scaffold post title content:text photo user:references
    rake db:migrate
~~~
Was 버킷 이미지 사용하려면
~~~shell
    gem "fog-aws"
    cd ~
    vi ~/.bashrc #에 아이디,비번 저장
    source .bashrc
    #real_board로 이동해서
    EVN['아이디']
~~~
업로더 생성
~~~shell
    rails g uploader photo
    #post.rb에 mount_uploader :photo, PhotoUploader추가
~~~
미니매직 설치
~~~shell
    gem "mini_magick"
    brew install imagemagick

    bundle install
~~~
public/uploads/movie/image_url/1에 image.rb파일 생성하고 아래 내용 추가
~~~ruby
    require "mini_magick"

    image = MiniMagick::Image.open("input.jpg")
    puts image.path #=> "/var/folders/k7/6zx6dx6x7ys3rv3srh0nyfj00000gn/T/magick20140921-75881-1yho3zc.jpg"
    # image.resize "100x100"
    # image.format "png"
    # image.write "output.png"

    #PhotoUploader에서 주석인 부분 수정
    #서버 다시 돌리고 new post해준 뒤 aws bucket확인하면 thumb인지 뭔지 생김
~~~  
Photo_uploader.rb에서
~~~ruby
    version :small do
        process resize_to_fill: [200, 200]
    end

    version :small do
        process resize_to_fit: [200, 200]
    end
~~~
bootstrap에서 로그인 폼 가져와서 사용

aws ses사용하려면...
~~~shell
    #config/initializers/aws_sdk.rb에 2줄 추가
    #config/initializers/devise 에 aws에 인증받은 이메일 넣는다
~~~
Amazon light sail : c9이랑 비슷하게 가상머신을 만들어 준다. ec2의 경량형 버전이라고 보면된다.
