Feature: Test soap api temperature .


  Background:

    * url 'https://www.w3schools.com/xml/tempconvert.asmx'

    * def pattern = 'YYYY-MM-DDTHH:mm:ss.sssZ'
    * def getDate = new Date()

  @scn1
  Scenario: 1. Celsius to Farenheit Conversion scenario
    * def today = Date()
    * print 'Scenario: 4 Started at:>>>>>>>>>>>>>>>>>>>>>>>> ',today
    Given request
    """
    <?xml version="1.0" encoding="utf-8"?>
<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:Body>
    <CelsiusToFahrenheit xmlns="https://www.w3schools.com/xml/">
      <Celsius>20</Celsius>
    </CelsiusToFahrenheit>
  </soap12:Body>
</soap12:Envelope>
    """
    And header Content-Type = 'application/soap+xml; charset=utf-8'
    When method post
    Then status 200
    And print response
    Then match /Envelope/Body/CelsiusToFahrenheitResponse/CelsiusToFahrenheitResult == 68

  @scn2
  Scenario: 2. Farenheit to Celsius Conversion
    * def today = Date()
    * print 'Scenario: 5 Started at:>>>>>>>>>>>>>>>>>>>>>>>> ',today

    Given request
    """
    <?xml version="1.0" encoding="utf-8"?>
<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:Body>
    <FahrenheitToCelsius xmlns="https://www.w3schools.com/xml/">
      <Fahrenheit>75</Fahrenheit>
    </FahrenheitToCelsius>
  </soap12:Body>
</soap12:Envelope>
    """
    And header Content-Type = 'application/soap+xml; charset=utf-8'
    When method post
    Then status 200
    And print response
    Then match /Envelope/Body/FahrenheitToCelsiusResponse/FahrenheitToCelsiusResult == 23.8888888888889


   @scn3
  Scenario: 3. call scenario fpr input
     * def today = Date()
     * print 'Scenario: 6 Started at:>>>>>>>>>>>>>>>>>>>>>>>> ',today

     * print ' ***************** This is calling Scenario 1 in scenario 3'
    * def response = call read('TemperatureConverter.feature@scn1')
    * print '------------------>', response
     * def res1 = $response..CelsiusToFahrenheitResult
     * print '==========>', res1
     Then match res1[0] == '68'

