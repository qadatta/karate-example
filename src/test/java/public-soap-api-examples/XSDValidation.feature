Feature: Test soap api temperature .




  @scn1
  Scenario: Validate XSD File
    * def today = Date()
    * print 'Validating xsd FIle... ',today
    * def validateXsd =
      """
      function(args) {
       var xsdValidator = Java.type('examples.users.XSDValidator');
       var valid = xsdValidator.validateXMLSchema(args,'students.xml')
       return valid;
      }"""

    When print 'Validating xsd against xml'
    * def result = call validateXsd 'students.xsd'
  * print '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.'
    * print result

    Then match true == result