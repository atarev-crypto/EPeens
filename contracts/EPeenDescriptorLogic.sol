// SPDX-License-Identifier: MIT

/*********************************
*                                *
*               8===D            *
*                                *
 *********************************/

pragma solidity ^0.8.13;

import './lib/base64.sol';
import "./IEPeenDescriptor.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract EPeenDescriptorLogic is IEPeenDescriptor {
    struct Color {
        string value;
        string name;
    }
    struct Trait {
        string content;
        string name;
        Color color;
    }
    using Strings for uint256;

    string private constant SVG_END_TAG = '</svg>';

    function tokenURI(uint256 tokenId, uint256 seed) external pure override returns (string memory) {
        uint256[4] memory colors = [seed % 100000000000000 / 1000000000000, seed % 10000000000 / 100000000, seed % 1000000 / 10000, seed % 100];
        Trait memory head = gethead(seed / 100000000000000, colors[0]);
        Trait memory jizz = getjizz(seed % 1000000000000 / 10000000000, colors[1]);
        Trait memory length = getlength(seed % 100000000 / 1000000, colors[2]);
        Trait memory balls = getballs(seed % 10000 / 100, colors[3]);
        string memory colorCount = calculateColorCount(colors);

        string memory rawSvg = string(
            abi.encodePacked(
                '<svg width="320" height="320" viewBox="0 0 320 320" xmlns="http://www.w3.org/2000/svg">',
                '<rect width="100%" height="100%" fill="#444444"/>',
                '<text x="160" y="160" font-family="Courier,monospace" font-weight="700" font-size="20" text-anchor="middle" letter-spacing="1">',
                balls.content,
                length.content,
                head.content,
                jizz.content,
                '</text>',
                SVG_END_TAG
            )
        );

        string memory encodedSvg = Base64.encode(bytes(rawSvg));
        string memory description = 'EPeen';

        return string(
            abi.encodePacked(
                'data:application/json;base64,',
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{',
                            '"name":"EPeen #', tokenId.toString(), '",',
                            '"description":"', description, '",',
                            '"image": "', 'data:image/svg+xml;base64,', encodedSvg, '",',
                            '"attributes": [{"trait_type": "Head", "value": "', head.name,' (',head.color.name,')', '"},',
                            '{"trait_type": "jizz", "value": "', jizz.name,' (',jizz.color.name,')', '"},',
                            '{"trait_type": "length", "value": "', length.name,' (',length.color.name,')', '"},',
                            '{"trait_type": "balls", "value": "', balls.name,' (',balls.color.name,')', '"},',
                            '{"trait_type": "Colors", "value": ', colorCount, '}',
                            ']',
                            '}')
                    )
                )
            )
        );
    }

    function getColor(uint256 seed) private pure returns (Color memory) {
        if (seed == 10) {
            return Color("#e60049", "UA Red");
        }
        if (seed == 11) {
            return Color("#82b6b9", "Pewter Blue");
        }
        if (seed == 12) {
            return Color("#b3d4ff", "Pale Blue");
        }
        if (seed == 13) {
            return Color("#00ffff", "Aqua");
        }
        if (seed == 14) {
            return Color("#0bb4ff", "Blue Bolt");
        }
        if (seed == 15) {
            return Color("#1853ff", "Blue RYB");
        }
        if (seed == 16) {
            return Color("#35d435", "Lime Green");
        }
        if (seed == 17) {
            return Color("#61ff75", "Screamin Green");
        }
        if (seed == 18) {
            return Color("#00bfa0", "Caribbean Green");
        }
        if (seed == 19) {
            return Color("#ffa300", "Orange");
        }
        if (seed == 20) {
            return Color("#fd7f6f", "Coral Reef");
        }
        if (seed == 21) {
            return Color("#d0f400", "Volt");
        }
        if (seed == 22) {
            return Color("#9b19f5", "Purple X11");
        }
        if (seed == 23) {
            return Color("#dc0ab4", "Deep Magenta");
        }
        if (seed == 24) {
            return Color("#f46a9b", "Cyclamen");
        }
        if (seed == 25) {
            return Color("#bd7ebe", "African Violet");
        }
        if (seed == 26) {
            return Color("#fdcce5", "Classic Rose");
        }
        if (seed == 27) {
            return Color("#FCE74C", "Gargoyle Gas");
        }
        if (seed == 28) {
            return Color("#eeeeee", "Bright Gray");
        }
        if (seed == 29) {
            return Color("#7f766d", "Sonic Silver");
        }

        return Color('','');
    }

    function gethead(uint256 seed, uint256 colorSeed) private pure returns (Trait memory) {
        Color memory color = getColor(colorSeed);
        string memory content;
        string memory name;
        if (seed == 10) {
            content = "D";
            name = "The D";
        }
        if (seed == 11) {
            content = unicode"¢";
            name = "Pierced";
        }
        if (seed == 12) {
            content = unicode"Ↄ";
            name = "Smoov";
        }
        if (seed == 13) {
            content = ">";
            name = "Pointed";
        }
        if (seed == 14) {
            content = "}";
            name = "Reservoir Tip";
        }
        if (seed == 15) {
            content = "?";
            name = "The Drip";
        }
        if (seed == 16) {
            content = unicode"ↁ";
            name = "Thick";
        }

        return Trait(string(abi.encodePacked('<tspan fill="', color.value, '">', content, '</tspan>')), name, color);
    }

    function getjizz(uint256 seed, uint256 colorSeed) private pure returns (Trait memory) {
        Color memory color = getColor(colorSeed);
        string memory content;
        string memory name;
        if (seed == 10) {
            content = "";
            name = "Anejaculation";
        }
        if (seed == 11) {
            content = "~";
            name = "A Little";
        }
        if (seed == 12) {
            content = "---";
            name = "Piss, actually";
        }
        if (seed == 13) {
            content = "~~~";
            name = "Jizz";
        }
        if (seed == 14) {
            content = "~~~~~";
            name = "Porn Star";
        }
        if (seed == 15) {
            content = "*";
            name = "Small and Sticky";
        }

        return Trait(string(abi.encodePacked('<tspan fill="', color.value, '">', content, '</tspan>')), name, color);
    }

    function getlength(uint256 seed, uint256 colorSeed) private pure returns (Trait memory) {
        Color memory color = getColor(colorSeed);
        string memory content;
        string memory name;
        if (seed == 10) {
            content = "";
            name = "Short but Sweet";
        }
        if (seed == 11) {
            content = "-";
            name = "Micro";
        }
        if (seed == 12) {
            content = "==";
            name = "Foot Size Doesn't Matter";
        }
        if (seed == 13) {
            content = "===";
            name = "Average";
        }
        if (seed == 14) {
            content = "====";
            name = "Above Average";
        }
        if (seed == 15) {
            content = "/////";
            name = "Monster";
        }
        if (seed == 16) {
            content = "===============";
            name = "OMG";
        }

        return Trait(string(abi.encodePacked('<tspan fill="', color.value, '">', content, '</tspan>')), name, color);
    }

    function getballs(uint256 seed, uint256 colorSeed) private pure returns (Trait memory) {
        Color memory color = getColor(colorSeed);
        string memory content;
        string memory name;
        
        if (seed == 10) {
            content = "8";
            name = "Classic";

        }
        if (seed == 11) {
            content = unicode"Ɛ";
            name = "Smoov";

        }
         if (seed == 12) {
            content = ":";
            name = "Tiny";

        }
        if (seed == 13) {
            content = "*";
            name = "Uniball";

        }
         if (seed == 14) {
            content = unicode"°";
            name = "Amputee";

        }

        return Trait(string(abi.encodePacked('<tspan fill="', color.value, '">', content, '</tspan>')), name, color);
    }

    function calculateColorCount(uint256[4] memory colors) private pure returns (string memory) {
        uint256 count;
        for (uint256 i = 0; i < 4; i++) {
            for (uint256 j = 0; j < 4; j++) {
                if (colors[i] == colors[j]) {
                    count++;
                }
            }
        }

        if (count == 4) {
            return '4';
        }
        if (count == 6) {
            return '3';
        }
        if (count == 8 || count == 10) {
            return '2';
        }
        if (count == 16) {
            return '1';
        }

        return '0';
    }
}