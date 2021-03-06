describe "String extensions", ->

  describe ".teaser()", ->

    it "should remove extra whitespace", ->
      expect(" it was the    worst of times  ".teaser())
        .toBe("it was the worst of times")

    it "should return the desired number of words", ->
      expect("it was the worst of times".teaser(4))
        .toBe("it was the worst ...")

    it "should truncate if there are too many characters", ->
      expect("it's supercalifragilisticexpialadocious".teaser(2))
        .toBe("it's supercalifr...")
