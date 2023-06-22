// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;


contract TimestampConverter {
  /**
 * @dev Converts a UNIX timestamp to a formatted date and time string.
 * @param timestamp The UNIX timestamp to convert.
 * @return The formatted date and time string.
 */
function convertTimestamp(uint256 timestamp) public pure returns (string memory) {
    // Convert the UNIX timestamp to a DateTime object
    uint256 unixTimestamp = timestamp;
    uint256 secondsPerDay = 86400;
    uint256 secondsPerHour = 3600;
    uint256 secondsPerMinute = 60;

    // Calculate the number of days, hours, minutes, and seconds
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

/**
 * @dev Retrieves the year component from a UNIX timestamp.
 * @param timestamp The UNIX timestamp.
 * @return The year component of the timestamp.
 */
function getYear(uint256 timestamp) public pure returns (uint256) {
    // Convert the UNIX timestamp to a DateTime object
    uint256 unixTimestamp = timestamp;
    uint256 secondsPerDay = 86400;

    // Calculate the number of days
    uint256 dayx = unixTimestamp / secondsPerDay;

    // Calculate the year
    uint256 year = 1970 + (dayx / 365);

    return year;
}


 /**
 * @dev Retrieves the month component from a UNIX timestamp.
 * @param timestamp The UNIX timestamp.
 * @return The month component of the timestamp.
 */
function getMonth(uint256 timestamp) public pure returns (uint256) {
    // Convert the UNIX timestamp to a DateTime object
    uint256 unixTimestamp = timestamp;
    uint256 secondsPerDay = 86400;

    // Calculate the number of days
    uint256 dayx = unixTimestamp / secondsPerDay;

    // Calculate the month
    uint256 month = ((dayx % 365) / 30);

    return month;
}

/**
 * @dev Retrieves the day component from a UNIX timestamp.
 * @param timestamp The UNIX timestamp.
 * @return The day component of the timestamp.
 */
function getDay(uint256 timestamp) public pure returns (uint256) {
    // Convert the UNIX timestamp to a DateTime object
    uint256 unixTimestamp = timestamp;
    uint256 secondsPerDay = 86400;

    // Calculate the number of days
    uint256 dayx = (unixTimestamp / secondsPerDay) + 1;

    // Calculate the year and month
    uint256 year = 1970 + (dayx / 365);
    uint256 month = ((dayx % 365) / 30);

    // Calculate the day within the month
    uint256 daysInMonth = getDaysInMonth(month, year);
    uint256 day = (dayx % daysInMonth);

    return day;
}

/**
 * @dev Retrieves the number of days in a given month of a specific year.
 * @param month The month.
 * @param year The year.
 * @return The number of days in the month.
 */
function getDaysInMonth(uint256 month, uint256 year) internal pure returns (uint256) {
    if (month == 2) {
        if (isLeapYear(year)) {
            return 29;
        } else {
            return 28;
        }
    } else if (month == 4 || month == 6 || month == 9 || month == 11) {
        return 30;
    } else {
        return 31;
    }
}

/**
 * @dev Checks if a given year is a leap year.
 * @param year The year.
 * @return A boolean indicating whether the year is a leap year.
 */
function isLeapYear(uint256 year) internal pure returns (bool) {
    if (year % 4 != 0) {
        return false;
    } else if (year % 100 != 0) {
        return true;
    } else if (year % 400 != 0) {
        return false;
    } else {
        return true;
    }
}

/**
 * @dev Retrieves the hour component from a UNIX timestamp.
 * @param timestamp The UNIX timestamp.
 * @return The hour component of the timestamp.
 */
function getHour(uint256 timestamp) public pure returns (uint256) {
    // Convert the UNIX timestamp to a DateTime object
    uint256 unixTimestamp = timestamp;
    uint256 secondsPerDay = 86400;
    uint256 secondsPerHour = 3600;

    // Calculate the number of hours
    uint256 hoursx = (unixTimestamp % secondsPerDay) / secondsPerHour;

    return hoursx;
}


/**
 * @dev Retrieves the minute component from a UNIX timestamp.
 * @param timestamp The UNIX timestamp.
 * @return The minute component of the timestamp.
 */
function getMinute(uint256 timestamp) public pure returns (uint256) {
    // Convert the UNIX timestamp to a DateTime object
    uint256 unixTimestamp = timestamp;
    uint256 secondsPerHour = 3600;
    uint256 secondsPerMinute = 60;

    // Calculate the number of minutes
    uint256 minutesx = (unixTimestamp % secondsPerHour) / secondsPerMinute;

    return minutesx;
}

/**
 * @dev Retrieves the second component from a UNIX timestamp.
 * @param timestamp The UNIX timestamp.
 * @return The second component of the timestamp.
 */
function getSecond(uint256 timestamp) public pure returns (uint256) {
    // Convert the UNIX timestamp to a DateTime object
    uint256 unixTimestamp = timestamp;
    uint256 secondsPerMinute = 60;

    // Calculate the number of seconds
    uint256 secondsx = unixTimestamp % secondsPerMinute;

    return secondsx;
}


 /**
 * @dev Helper function to convert a uint256 to a string representation.
 * @param num The uint256 number to convert.
 * @return The string representation of the input number.
 */
function uint2str(uint256 num) internal pure returns (string memory) {
    // Check if the number is zero
    if (num == 0) {
        return "0";
    }

    uint256 temp = num;
    uint256 digits;

    // Count the number of digits in the number
    while (temp != 0) {
        digits++;
        temp /= 10;
    }

    // Create a buffer to store the digits
    bytes memory buffer = new bytes(digits);

    // Convert the number to string by extracting each digit
    while (num != 0) {
        digits -= 1;
        buffer[digits] = bytes1(uint8(48 + uint256(num % 10)));
        num /= 10;
    }

    return string(buffer);
}

}


