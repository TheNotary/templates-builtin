package com.example.java.myappgroup

import com.example.java.myappgroup.Utils
import spock.lang.Specification

class UtilsSpec extends Specification {
  String testConstant = 'test_constant'

  def setupTest() {
    def utils = new Utils()
    [utils]
  }

  def "it can work"() {
    given:
      def (utils) = setupTest()
    when: "we call performWork"
      def actualOutput = utils.performWork()
    then: "we get some kind of string output"
      actualOutput == "hihi"
  }
}

