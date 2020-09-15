Feature: Test soap api NumberToWords.
  Returns the word corresponding to the positive number passed as parameter. Limited to quadrillions.


  Background:

    * url 'https://www.dataaccess.com/webservicesserver/NumberConversion.wso'

  Scenario: 1. Test number to words api for valid input
    Given request
    """
    <?xml version="1.0" encoding="utf-8"?>
      <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
         <soap:Body>
           <NumberToWords xmlns="http://www.dataaccess.com/webservicesserver/">
              <ubiNum>500</ubiNum>
           </NumberToWords>
      </soap:Body>
    </soap:Envelope>
    """
    And header Content-Type = 'text/xml; charset=utf-8'
    When method post
    Then status 200
    And print response
    Then match /Envelope/Body/NumberToWordsResponse/NumberToWordsResult == 'five hundred'

