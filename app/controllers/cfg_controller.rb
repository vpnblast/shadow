class CfgController < ApplicationController
  def index
  end

  # generate config.json
  def generate
    @users = User.all

    if (OS == "W")
      path = "d:/"
    else
      path = "/root/shadowsocks-nodejs/"
    end

    name = "config.json"

    t = Time.new
    date_cur = t.strftime("%Y-%m-%d")

    name_bak = "#{date_cur}_#{name}"

    file = "#{path}#{name}"
    file_bak = "#{path}#{name_bak}"

    puts "Checking file: #{file}"

    if (FileTest.exists?(file))
      puts "Backing up the initial file to #{file_bak}"
      File.rename("#{file}", "#{file_bak}")
    else
      # File does not exist
    end

    str = "{\n"
    str += "\"port_password\": {\n"

    date_now = Date.today()

    # get username and password from database
    @users.each do |user|
      # check if the user is expired
      date_end = Date.parse(user.date_end)

      comp = date_now <=> date_end

      if comp == -1 || comp == 0
        str += "\"#{user.username}\":\"#{user.password}\",\n"
      end
    end

    # remove the last ",\n"
    str = str.chop
    str = str.chop

    # add another "\n"
    str += "\n"

    str += "},\n"
    str += "\"timeout\": 600,\n"
    str += "\"cache_enctable\": true\n"
    str += "}\n"

    # generate the file
    fout = File.new(file, "w")
    fout.puts(str)
    fout.close

    # execute start.sh
    if (OS == "W")
    else
      log = `bash /root/shadowsocks-nodejs/start.sh`
    end
  end
end
