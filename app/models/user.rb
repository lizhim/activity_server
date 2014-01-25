class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true
  validates :password_confirm, presence: true
  validates :question, presence: true
  validates :answer, presence: true
  #validates_presence_of :name, :message => "用户名不能为空"
  #validates_length_of :name, :in => 1..10, :message => "用户名长度不正确"
  #validates_presence_of :password, :message => "密码不能为空"
  #validates_length_of :password, :in => 1..10, :message => "密码长度不正确"
  #validates_presence_of :question, :message => "密保问题不能为空"
  #validates_length_of :question, :in => 1..10, :message => "密保问题长度不正确"
  #validates_presence_of :answer, :message => "答案不能为空"
  #validates_length_of :answer, :in => 1..10, :message => "答案长度不正确"
end
