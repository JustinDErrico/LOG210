require 'digest/sha1'

class Client < ActiveRecord::Base

  CLIENT_TYPES = {visitor: 'visitor', administrator: 'administrator', entrepreneur: 'entrepreneur', restaurator: 'restaurator', deliverer: 'deliverer'}

  attr_accessible :address, :dateOfBirth, :emailAddress, :name, :password, :phoneNumber, :password_confirmation, :clientType, :zipCode
  attr_accessor :password_confirmation

  before_save :encrypt_password_before_safe

  def encrypt_password_before_safe
    if self.password != ''
      self.password = Digest::SHA1.hexdigest(self.password)
    end
  end


  #Validation des champs du formulaire
    zip_regex_canada = %r{[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1} *\d{1}[A-Z]{1}\d{1}$}
    validate :check_password_confirmation
    validate :check_unique_email
    validates :name, length: { minimum: 2 }
    validates :address, length: { minimum: 2 }
    validates :zipCode, :presence => true, :format => { :with => zip_regex_canada }
    validates :phoneNumber, format: { with: /\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/ }
    validates :emailAddress, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
    validates :password, length: { minimum: 2 }
    validates :password_confirmation, length: { minimum: 2 }
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

  def check_password_confirmation
    if (password != '' && password_confirmation != '')
      errors.add(password, "Needs to match the confirmation password.") if password != password_confirmation
    end
  end

  def check_unique_email
    errors.add(:emailAddress, "is used by another user.") if(Client.find_all_by_emailAddress(emailAddress).count != 0 && Client.find_all_by_emailAddress(emailAddress).first.id != self.id)
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
