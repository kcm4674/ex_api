class HomesController < ApplicationController
  ## rest-client Gem을 사용하기 위한 모듈 정의
  require 'rubygems'
  require 'rest_client'
  require 'cgi'
  
  def index
    ## API를 통신할 홈페이지 주소
    url = "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty?serviceKey=#{ENV["GO_DATA_API"]}"

    ## API 통신을 하면서 우리쪽에서 보낼 데이터 요청값
    headers = { :params => { CGI::escape('numOfRows') => '60', CGI::escape('pageNo') => '1', CGI::escape('sidoName') => '서울', CGI::escape('ver') => '1.3' } }

    ## url, header 변수를 기반으로 공공데이터 쪽으로 데이터 요청을 보냄.
    @finedust = RestClient::Request.execute :method => 'GET', :url => url , :headers => headers

    ## 데이터 결과값을 받아냄.
    @doc = Nokogiri::XML(@finedust.body)

    ## 여기 줄 부터 데이터를 우리 입맛대로 가공 (일단 수집한 데이터들을 배열에 담아내며 정리.)
    ## 미세먼지 Attribute Mapping
    @finedust_time = @doc.xpath("//dataTime") # 미세먼지 측정시간 전체만을 따로 @finedust_time 변수에 담아냄.
    @finedust_station = @doc.xpath("//stationName") # 시 내 지역(동, 읍 등)만을 따로 @finedust_station 변수에 담아냄.
    @finedest_pm10 = @doc.xpath("//pm10Value") # PM10 수치 (미세먼지)만을 따로 @finedest_pm10 변수에 담아냄.
    @finedest_pm25 = @doc.xpath("//pm25Value") # PM25 수치 (초미세먼지)만을 따로 @finedest_pm25 변수에 담아냄.

    ## 2차원 배열을 만듭니다. (행 : 4, 열 : @finedust_time 변수의 갯수만큼)
    @finedust_to_array = Array.new(@finedust_time.length) {Array.new(4)}

    ## 0부터 @finedust_time-1개 까지 반복loop 실행 (@finedust_time의 총 갯수에서 -1개를 안하면 하나가 꼭 남음.)
    for i in 0..@finedust_time.length-1
      @finedust_to_array[i][0] = @finedust_station[i].text
      @finedust_to_array[i][1] = @finedest_pm10[i].text
      @finedust_to_array[i][2] = @finedest_pm25[i].text
      @finedust_to_array[i][3] = @finedust_time[i].text
    end
    ## => finedust_to_array[0] => ["중구", "32", "26", "2019-08-06 01:00"]
    ## => finedust_to_array[0][0] => "중구"
  end
end
