require 'digest/sha1'

class Client < ActiveRecord::Base

  CLIENT_TYPES = {visitor: 'visitor', administrator: 'administrator', entrepreneur: 'entrepreneur', restaurator: 'restaurator', deliverer: 'deliverer'}

  attr_accessible :address, :dateOfBirth, :emailAddress, :name, :password, :phoneNumber, :password_confirmation, :clientType, :zipCode
  attr_accessor :password_confirmation

  #Validation des champs du formulaire
    zip_regex_canada = %r{[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1} *\d{1}[A-Z]{1}\d{1}$}
    validates :name, length: { minimum: 2 }
    validates :address, length: { minimum: 2 }
    validates :zipCode, :presence => true, :format => { :with => zip_regex_canada }
    validates :phoneNumber, format: { with: /\d{3}\d{3}\d{4}/}
    validates :emailAddress, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }
    validates :password, length: { minimum: 2 }
   #Fin validation du formulaire

  def setAsAdmin
    self.clientType = CLIENT_TYPES[:administrator]
  end

  def setAsVisitor
    self.clientType = CLIENT_TYPES[:visitor]
  end

  def setAsEntrepreneur
    self.clientType = CLIENT_TYPES[:entrepreneur]
  end

  def setAsRestaurator
    self.clientType = CLIENT_TYPES[:restaurator]
  end

  def setAsDeliverer
    self.clientType = CLIENT_TYPES[:deliverer]
  end

  def self.authenticate(email, password)
    client = find_by_emailAddress(email)
    if client && client.password ==Digest::SHA1.hexdigest(password)
      client
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password = Digest::SHA1.hexdigest(password)
    end
  end

end
