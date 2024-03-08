require_relative 'emailVerification' 

# Initialize the client with an API key if necessary
client = EmailVerification::Client.new('bd300b5adb4b4e8f9497ae7b75a59e64')

# Create an instance of OtpSendReq with desired parameters
otp_send_req = {
    "phone" => "+923004242293",
    "tmpl_sms" => "Your verification code is {112233}",
    "token_len" => 4,
    "expire_seconds" => 300,
}

# Call the send_otp method
otp_send_resp = client.send_otp(otp_send_req)

# Handle response
puts "Response code: #{otp_send_resp["code"]}"
puts "Response message: #{otp_send_resp["msg"]}"

puts "Enter OTP Code : "
otp = gets.chomp

otp_verify_req = {
    "phone" => "+923004242293",
    "token" => "#{otp}",
    "consume" => true,
}

otp_verify_resp = client.verify(otp_verify_req)
puts "Response code: #{otp_verify_resp["code"]}"
puts "Response message: #{otp_verify_resp["msg"]}"

# email = 'sahal.abdullah@mslm.io'
# resp = client.single_verify(email)

# puts resp 
