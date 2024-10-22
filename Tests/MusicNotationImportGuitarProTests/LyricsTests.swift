//
//	LyricsTests.swift
//	music-notation-import-guitarpro-tests
//
//	Created by Steven Woolgar on 2024-10-22.
//	Copyright © 2024 Steven Woolgar. All rights reserved.
//

@testable import MusicNotationImportGuitarPro
import SWXMLHash
import Testing

@Suite final class LyricsTests {
	@Test func parseArray() async throws {
		let xmlString = """
      <Lyrics dispatched="true">
        <Line>
          <Text>
  Guess who  just  got  back __  to- day? __
  Those wild- eyed boys __ that had been a- way __

  Hav- en't changed,  haven't  much to say
  But man, I still think those cats are great
  They were as- king if you were ar-ound __ 
  How you  was,  where you could be found __
  I told them you were li- ving down-  town 
  Dri-ving all the old  men cra-zy
  
  The boys are back in town __
  the boys are back in town __
  I said the boys are back in to- __ __ __ __ wn
  the boys are back in town __
  the boys are back in town __
  the boys are back in town __
  the boys are back in town __
  the boys are back in town __
  
  You know the chick that used to dance a lot __
  Ev-ery night  she'd be on  the floor sha- king what she'd got 
  Man when I tell you she was cool, she was red  hot 
  I mean she was stea-ming
  And that time  over at john-ny's  place 
  Well this chick got up and she_slapped joh-nny's  face 
  Man __ we just fell a- bout the place
  If that chick don't want to know, forg- et her
  
  The boys are back in town __
  the boys are back in town __
  I said the boys are back in to- __ __ __ __ wn
  the boys are back in town __
  the boys are back in town __
  the boys are back in town __
  the boys are back in town __
  the boys are back in town __
  
  Spread the word  a- round
  Guess Who's back in town __
  You  spread the word  a- round
  Fri- day night  they'll be dressed  to kill __ 
  Down at Di- no's  bar  and grill __
  The drink  will flow and blood will spill
  And If the boys  want to fight, you'd bet- ter let  them
  That juke- box ion the cor-  ner blas- ting out my fa- vourite song 
  The nights  are getting  war- __ mer, it won't  be long  __
  Won't be long __ till  sum- mer comes
  Now that the boys  are here a- gain
  The boys are back in town __
  the boys are back in town __
  the boys are back in to- __ __ __ __ wn
  the boys are back in town __
  the boys are back in town __
  the boys are back in town __
  Spread the word a-round
  the boys are back in town __
  the boys are back in town __
  
  The boys are back
  The boys are back
  
  The boys are back  in  ti- me a- gain 
  Been han- gin' down __ at Di-no's
  The boys are back  in  ti-me a-gain
          </Text>
          <Offset>0</Offset>
        </Line>
        <Line>
          <Text></Text>
          <Offset>0</Offset>
        </Line>
        <Line>
          <Text></Text>
          <Offset>0</Offset>
        </Line>
        <Line>
          <Text></Text>
          <Offset>0</Offset>
        </Line>
        <Line>
          <Text></Text>
          <Offset>0</Offset>
        </Line>
      </Lyrics>
  """
		let xmlParser = XMLHash.parse(xmlString)

		let lyrics: Lyrics = try xmlParser["Lyrics"].value()
		#expect(lyrics.lines.count == 5)
		#expect(lyrics.dispatched == true)
	}
}
