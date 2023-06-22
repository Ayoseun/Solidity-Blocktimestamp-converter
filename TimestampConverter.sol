// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract TimestampConverter {
    function convertTimestamp(uint256 timestamp) public pure returns (string memory) {
        // Convert the UNIX timestamp to a DateTime object
        uint256 unixTimestamp = timestamp;
        uint256 secondsPerDay = 86400;
        uint256 secondsPerHour = 3600;
        uint256 secondsPerMinute = 60;

        uint256 dayx = unixTimestamp / secondsPerDay;
        uint256 hoursx = (unixTimestamp % secondsPerDay) / secondsPerHour;
        uint256 minutesx = (unixTimestamp % secondsPerHour) / secondsPerMinute;
        uint256 secondsx = unixTimestamp % secondsPerMinute;

        // Calculate the year and month
        uint256 year = 1970 + (dayx / 365);
        uint256 month = ((dayx % 365) / 30);

        // Construct the date and time string
        string memory dateTime = string(abi.encodePacked(
            "Year: ", uint2str(year), ", Month: ", uint2str(month), ", ",
            uint2str(dayx % 30), " days, ",
            uint2str(hoursx), " hours, ",
            uint2str(minutesx), " minutes, ",
            uint2str(secondsx), " seconds"
        ));

        return dateTime;
    }

    // Helper function to convert a uint256 to string
    function uint2str(uint256 num) internal pure returns (string memory) {
        if (num == 0) {
            return "0";
        }

        uint256 temp = num;
        uint256 digits;

        while (temp != 0) {
            digits++;
            temp /= 10;
        }

        bytes memory buffer = new bytes(digits);

        while (num != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(num % 10)));
            num /= 10;
        }

        return string(buffer);
    }

}
