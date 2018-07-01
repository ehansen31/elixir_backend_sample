defmodule ElixirBackendSampleWeb.Email do
    import Bamboo.Email
  
    def password_reset_email(userObj, new_password) do
      new_email(
        to: userObj.email,
        from: "noreply@murmillosoftware.com",
        subject: "Your New Password",
        # html_body: "<strong>Thanks for joining!</strong>",
        text_body: "Your new password is: " <> new_password
      )
    end
  end