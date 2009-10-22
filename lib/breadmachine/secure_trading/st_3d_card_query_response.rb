module BreadMachine
  module SecureTrading

    # A response object which tells us what happened with a 3-D Secure
    # enrollment check.
    #
    class St3dCardQueryResponse < XpayResponse

      # Checks whether the request was successfully processed.  A true response
      # does not necessarily mean anything other than the XPay service
      # acknowledged that it has talked to you successfully.
      #
      # From the XPay docs:
      # self.result '2' means "the request was successfully processed but the
      # 3-D Secure process cannot be continued".  This would happen in the case
      # of a credit card provider which is not participating in 3-D Secure.
      #
      def successful?
        self.result == '1' || self.result == '2'
      end

      # Is the card enrolled in 3-D Secure?
      #
      # Returns "Y", "N", "U", "N/A"
      #
      # From our reading of the XPay documentation,
      # N/A (not available) will be returned in cases where the result is an error.
      # N (no) will be returned if the card is not currently enrolled.
      # U (unknown) will be returned in cases where the credit card provider
      #   returns an ambiguous response to the enrollment check.  You should
      #   redirect the  user to a 3-D Secure auth check page in this case.
      # Y (yes) will be returned if the card is enrolled. You should redirect the
      #   user to a 3-D Secure auth check page in this case.
      #
      def enrolled
        @xml.xpath('//OperationResponse/Enrolled').text
      end

      # If this is true, you should redirect your user to a 3-D Secure access
      # control server (ACS) page.
      #
      # Result = 1 from the card enrollment query means that the card issuer is
      # part of 3-D Secure and that a 3-D Secure auth should be performed.
      #
      # Enrolled = "Y" means that the card is enrolled in 3-D Secure and that
      # the user should be redirected to ACS to authenticate.
      #
      def three_d_auth_with_redirect?
        self.result == "1" && enrolled == "Y"
      end

      # If a card provider is part of 3D-Secure but the card is not enrolled,
      # it is still necessary to do a 3-D Secure auth request for funds even
      # though we do not need to redirect the user to the ACS server.
      #
      def three_d_auth_without_redirect?
        self.result == "1" && enrolled != "Y"
      end

      # If this returns true, you can perform a regular auth check for funds.
      #
      def normal_auth?
        self.result != "1"
      end

      # A unique reference generated according to the 3-D Secure specification
      # (currently up to 1024 bytes in base64 format). It will be returned to
      # the merchant in the case of receiving an <Enrolled> of Y. This can be
      # used by the merchant to tie up a response obtained from an ACS after the
      # customer’s authentication process.
      #
      def md
        @xml.xpath('//OperationResponse/MD').text
      end

      # The pa_req contains purchase transaction details upon which ACS
      #  authentication decisions are based.
      #
      # If you are making your own customised redirect page instead of using
      # the <Html> provided then this field MUST be included in that html, as a
      # hidden field.
      #
      def pa_req
        @xml.xpath('//OperationResponse/PaReq').text
      end

      # The URL of the 3-D Secure ACS page (see README) to redirect to.
      #
      def acs_url
        @xml.xpath('//OperationResponse/AcsUrl').text
      end
      
      # The URL which the ACS will send the user to after they have
      # authenticated.
      #
      # This is informational as you passed it in so hopefully you know what it
      # is. ;)
      #
      def term_url
        @xml.xpath('//OperationResponse/TermUrl').text
      end

      def transaction_reference
        @xml.xpath('//OperationResponse/TransactionReference').text
      end

      def transaction_verifier
        @xml.xpath('//OperationResponse/TransactionVerifier').text
      end

      def auth_type
        self.result == '1' ?
          BreadMachine::SecureTrading::St3dAuthRequest :
          BreadMachine::SecureTrading::AuthRequest
      end


      # The ACS HTML POST form returned by the request.  This is an extremely
      # ugly html page containing all of the form parameters needed to identify
      # the user for a 3-D Secure authentication check.  It's possible (and
      # probably desirable) to make your own page and style it how you want,
      # including the same parameters, but this page is a good first step
      # during integration.
      #
      # If you need to redirect a user to the 3-D Secure ACS page, you can do
      # something like
      #
      #  if response.should_redirect?
      #    render :text => CGI.unescape(response.html)
      #  end
      #
      # The returned HTML contains a javascript call which will submit the form
      # automatically with the correct POST parameters for this request (or
      # display an ugly HTML page telling the user to click to redirect to
      # 3-D Secure).
      #
      def html
        @xml.xpath('//OperationResponse/Html').text
      end

    end

  end
end

