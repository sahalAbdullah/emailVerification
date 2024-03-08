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
