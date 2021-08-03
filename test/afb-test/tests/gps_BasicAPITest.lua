--[[
   Copyright (C) 2018 "IoT.bzh"
   Author Frédéric Marec <frederic.marec@iot.bzh>

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.


   NOTE: strict mode: every global variables should be prefixed by '_'
--]]

local testPrefix ="gps_BasicAPITest_"

--[[
_AFT.setBeforeEach(function()
    os.execute("gpsfake -r -q ".._AFT.bindingRootDir.."/var/test.nmea &")
end)


_AFT.setAfterEach(function()
    os.execute("pkill -f -9 gpsfake")
    os.execute("pkill -9 gpsd")
end)
--]]

-- This tests the 'subscribe' verb of the gps API
_AFT.testVerbStatusSuccess(testPrefix.."subscribe","gps","subscribe", {value = "location" },
    nil,
    function()
        _AFT.callVerb("gps","unsubscribe", {value = "location" })
    end)

-- This tests the 'unsubscribe' verb of the gps API
_AFT.testVerbStatusSuccess(testPrefix.."unsubscribe","gps","unsubscribe",{value = "location" },
    function()
        _AFT.callVerb("gps","subscribe",{value = "location" })
    end,
    nil)

-- This tests the 'record' verb of the gps API
_AFT.testVerbStatusSuccess(testPrefix.."record","gps","record",{state= "on"},nil,
    function()
       _AFT.callVerb("gps","record",{state = "off"})
    end)

-- This tests the 'replay' verb of the gps API
    _AFT.describe(testPrefix.."replay", function()
    local api = "gps"

    _AFT.assertVerbStatusSuccess(api, "record", {state= "on"})
    _AFT.assertVerbStatusSuccess(api, "record", {state= "off"})
    _AFT.assertVerbStatusSuccess(api, "record", {state= "on"})
    _AFT.assertVerbStatusSuccess(api, "record", {state= "off"})

   end)

-- This tests the 'double off' verb of the gps API
_AFT.describe(testPrefix.."double off", function()
    local api = "gps"

    _AFT.assertVerbStatusSuccess(api, "record", {state= "on"})
    _AFT.assertVerbStatusSuccess(api, "record", {state= "off"})
    _AFT.assertVerbStatusError(api, "record", {state= "off"})

   end)

-- This tests the 'double subscribe' verb of the gps API
_AFT.describe(testPrefix.."double subscribe",
    function()
        local api = "gps"

        _AFT.assertVerbStatusSuccess(api, "subscribe",{value = "location"})
        _AFT.assertVerbStatusSuccess(api, "subscribe",{value = "location"})

    end)

-- This tests the 'unsubscribe' verb of the gps API
_AFT.testVerbStatusError(testPrefix.."unsubscribe","gps","sucribe",{value = "location" },
    function()
        _AFT.callVerb("gps","subscribe",{value = "location" })
    end, nil)

   -- This tests the 'location' verb of the gps API when we are not actually subscribed to a device
_AFT.testVerbStatusError(testPrefix.."location_with_wrong_argument","gps","location",{state= "on"}, nil, nil)

-- This tests the 'subscribe' verb of the gps API with wrong argument
_AFT.testVerbStatusError(testPrefix.."subscribe_with_wrong_argument","gps","subscribe", {value = "error" }, nil, nil)

-- This tests the 'unsubscribe' verb of the gps API with wrong argument
_AFT.testVerbStatusError(testPrefix.."unsubscribe_with_wrong_argument","gps","unsubscribe",{value = "error" }, nil, nil)

-- This tests the 'subscribe' verb of the gps API with wrong argument
_AFT.testVerbStatusError(testPrefix.."subscribe_with_wrong_argument","gps","subscribe", {}, nil, nil)

-- This tests the 'unsubscribe' verb of the gps API with wrong argument
_AFT.testVerbStatusError(testPrefix.."unsubscribe_with_wrong_argument","gps","unsubscribe",{}, nil, nil)

_AFT.exitAtEnd()
