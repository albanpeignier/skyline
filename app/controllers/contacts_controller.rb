class ContactsController < ApplicationController
  
  def index
    @contacts = Highrise::Person.find(:all, :params => { :term => params[:name] }, :from => "/people/search.xml").collect do |person|
      person.contact_data.phone_numbers.collect do |number| 
        Contact.new :name => "#{person.name} (#{number.location})", :number => number.number
      end
    end.flatten
  end

end
