class Avanti_download_from_to

  attr_accessor :identifier_pattern, :connection_profile, :number_from, :number_to
  
  def initialize(identifier_pattern, number_from, number_to, connection_profile='auth')
    identifier_pattern.length == 3 ? @identifier_pattern = identifier_pattern : abort('No valid identifier_pattern.')
    @connection_profile = connection_profile
    @number_from = number_from
    @number_to = number_to
  end 
  
  def retrieve_module(number)
    identifier_pattern = self.identifier_pattern
    connection_profile = self.connection_profile
    align_number = number.to_s.rjust(8, '0')
    retrieve_module = "\t<module name=\"AvantiRetrieve\">\n"
    retrieve_module += "\t\t<note></note>\n"
    retrieve_module += "\t\t<with-param name=\"select\" value=\"find |9 #{identifier_pattern}#{align_number}\"/>\n"
    retrieve_module += "\t\t<with-param name=\"output\" value=\"retrieve_#{identifier_pattern}#{align_number}.txt\"/>\n"
    retrieve_module += "\t\t<with-param name=\"connection_profile\" value=\"#{connection_profile}\"/>\n"
    retrieve_module += "\t\t<with-param name=\"xport_full\" value=\"record\"/>\n"     
    retrieve_module += "\t</module>\n"
    retrieve_module
  end
  
  def generate
    from = self.number_from
    to = self.number_to
    retrieve_modules = ''
    (from..to).each do |number|
      retrieve_modules += self.retrieve_module(number)
    end
    retrieve_modules
  end
  
  def write(filename = '')
    number_from = self.number_from
    number_to = self.number_to
    filename = "retrieve_#{identifier_pattern}_from_#{number_from}_to_#{number_to}_from_#{connection_profile}.xml" if filename == ''
    
    if File.exists? filename
      puts "File #{filename} exists."
    else    
      File.open(filename, 'w') do |file| 
        file.write("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n")
        file.write("<conversion>\n")
        file.write("<workflow>\n")
        file.write( self.generate )
        file.write("</workflow>\n")
        file.write("</conversion>\n")
      end
    end
  end



end


#main
identifier_pattern = ARGV[0]
number_from = ARGV[1]
number_to = ARGV[2]
connection_profile = ARGV[3] || 'ct_test'
a = Avanti_download_from_to.new(identifier_pattern, number_from, number_to, connection_profile)
a.write


