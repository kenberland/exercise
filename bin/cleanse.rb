output = File.open('/dev/stdout', 'w+')
TABLES = %w/users w9_forms/.freeze
$rubric = nil

SENSITIVE_KEYS = {
  'first_name'      => Proc.new { 'New ' + Faker::Name.first_name },
  'last_name'       => Proc.new { 'New ' + Faker::Name.last_name },
  'email'           => Proc.new { Faker::Internet.safe_email },
  'password_digest' => Proc.new { '$2a$10$5qbgDuD6kEC0kh6DychuvO3LtOacCeSQmJTQqxw2mPOj5MTqXJqpu' }, # "password1"
  'encrypted_ssn'   => Proc.new { 'BOGUS-ASCII-DATA' }
}

def parse_rubric(line)
  r = Regexp.new '^COPY \w+ \((.+)\) FROM stdin;'
  line.match(r)[1].split(/, /)
end

def target_table?(line)
  r = Regexp.new '^COPY (\w+)'
  TABLES.include?(line.match(r)[1])
end

def get_rubric(line)
  if target_table?(line)
    $rubric = parse_rubric(line)
  end
end

def zip_line(line)
  vals = line.split(/\t/)
  Hash[$rubric.zip(vals)]
end

def unzip(kv)
  kv.values
end

def replace_sensitive_keys(kv)
  kv.each do |k,v|
    kv[k] = SENSITIVE_KEYS[k].call if SENSITIVE_KEYS.keys.include?(k)
  end
end

def process_line(line)
  key_values = zip_line(line)
  key_values = replace_sensitive_keys(key_values)
  values = unzip(key_values)
  values.join("\t")
end

loop do
  begin
    line = STDIN.readline
    if line.index('COPY') == 0
      get_rubric(line)
    elsif line == "\\.\n"
      $rubric = nil
    elsif $rubric
      line = process_line(line)
    end
    output.puts line
  rescue EOFError
    break
  end
end
