require 'digest/sha1'

class Client < ActiveRecord::Base

  CLIENT_TYPES = {visitor: 'visitor', administrator: 'administrator', entrepreneur: 'entrepreneur', restaurator: 'restaurator', deliverer: 'deliverer'}

  attr_accessible :address, :dateOfBirth, :emailAddress, :name, :password, :phoneNumber, :password_confirmation, :clientType
  attr_accessor :password_confirmation

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
