# 공공데이터 API 통신 실습

## 1. Ruby/Ruby on Rails 정보
* Ruby : 2.6.3
* Rails : 5.2.3

## 2. Tutorial
<img src="/public/img/example.png?raw=true" width="500px">

* 해당 실습자료는 공공데이터 API 통신 실습 자료 입니다.
* 과정 참고 : https://github.com/kcm4674/ex_api/commits/master
* 공공데이터 : http://data.go.kr

## 3. 파일 소개
1. `app/controllers/homes_controller.rb` [<a target="_blank" href="/app/controllers/homes_controller.rb">이동</a>] @date_list 변수에 Market 모델 호출
2. `app/views/n_cafe/index.html.erb` [<a target="_blank" href="/app/views/homes/index.html.erb">이동</a>] View를 통해 사람들에게 페이지를 렌더링 후 보여줍니다.
3. `config/application.yml` [<a target="_blank" href="/config/application.yml">이동</a>] API Key 값을 관리하는 파일입니다.
    * 공공데이터 API키 값을 여기에 꼭 적어주세요!
    * 혹시 API Key 값을 적어놨어도 작동을 안하면, `app/controllers/homes_controller.rb` 로 이동 후, `#{ENV['GO_DATA_API']}` 자리에 직접 API Key값을 적어서 실습해주세요.
 
## 4. AWS Cloud9으로 프로젝트 가져가기

    git clone https://github.com/kcm4674/ex_api
    cd ex_api
    gem install rails --version=5.2.3
    bundle install
    rake db:drop; rake db:migrate; rake db:seed
    rails s
