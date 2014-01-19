# cfg.rake

task :update_cfg => :environment do

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

task :import_xlsx => :environment do
  file = "/root/shadow/import.xlsx"
  ptr = Roo::Excelx.new(file)

  cur_row = 2
  num_row = ptr.last_row

  loop {
    user = User.new

    puts "Importing the user..."

    # username
    obj = ptr.cell('A', cur_row)

    if (obj.class.to_s == "Float")
      user.username = obj.to_i
    else
      user.username = obj.to_s
    end

    # password
    obj = ptr.cell('B', cur_row)

    if (obj.class.to_s == "Float")
      user.password = obj.to_i
    else
      user.password = obj.to_s
    end

    user.date_begin = ptr.cell('A', 1)
    user.date_end = ptr.cell('B', 1)

    user.save

    if (cur_row == num_row)
      break
    end

    cur_row += 1
  }

  puts "Importing done!"

end

task :helloworld => :environment do
  puts "Hello World!"
end