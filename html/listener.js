let state = {
    blipId: null,
};
let pageList = new Array();
let currentPage = 1;
let numberPerPage = 36;
// i know this is trash but the id's dont increase sequentially.... so gotta hardcode
let BLIPIDS = [
    0,
    1,
    2,
    3,
    6,
    7,
    8,
    11,
    12,
    13,
    14,
    15,
    16,
    36,
    38,
    40,
    41,
    43,
    47,
    50,
    51,
    52,
    56,
    57,
    58,
    59,
    60,
    61,
    64,
    66,
    67,
    68,
    71,
    72,
    73,
    75,
    76,
    77,
    78,
    79,
    80,
    84,
    85,
    86,
    88,
    89,
    90,
    93,
    94,
    96,
    100,
    102,
    103,
    104,
    105,
    106,
    107,
    108,
    109,
    110,
    112,
    113,
    118,
    119,
    120,
    121,
    122,
    123,
    124,
    126,
    127,
    128,
    129,
    130,
    133,
    134,
    135,
    136,
    137,
    140,
    141,
    143,
    144,
    145,
    146,
    147,
    149,
    150,
    151,
    152,
    153,
    154,
    155,
    156,
    157,
    158,
    159,
    160,
    162,
    163,
    164,
    171,
    173,
    175,
    176,
    177,
    178,
    181,
    182,
    183,
    184,
    185,
    186,
    187,
    188,
    189,
    197,
    198,
    205,
    206,
    207,
    208,
    209,
    210,
    211,
    214,
    225,
    226,
    227,
    229,
    233,
    237,
    238,
    251,
    252,
    253,
    255,
    256,
    266,
    267,
    268,
    269,
    270,
    271,
    272,
    273,
    274,
    276,
    277,
    278,
    279,
    280,
    285,
    286,
    287,
    288,
    289,
    290,
    291,
    293,
    303,
    304,
    305,
    306,
    307,
    308,
    309,
    310,
    311,
    313,
    314,
    315,
    316,
    317,
    318,
    326,
    348,
    350,
    351,
    352,
    353,
    354,
    355,
    356,
    357,
    358,
    359,
    360,
    361,
    362,
    363,
    364,
    365,
    366,
    367,
    368,
    369,
    370,
    371,
    372,
    373,
    374,
    375,
    376,
    377,
    378,
    379,
    380,
    381,
    382,
    383,
    384,
    385,
    386,
    387,
    388,
    389,
    390,
    391,
    392,
    393,
    394,
    395,
    396,
    397,
    398,
    399,
    400,
    401,
    402,
    403,
    404,
    405,
    407,
    408,
    409,
    410,
    411,
    412,
    413,
    414,
    415,
    416,
    417,
    418,
    419,
    420,
    421,
    422,
    423,
    424,
    425,
    426,
    427,
    428,
    429,
    430,
    431,
    432,
    433,
    434,
    435,
    436,
    437,
    438,
    439,
    440,
    441,
    442,
    443,
    444,
    445,
    446,
    447,
    448,
    449,
    450,
    451,
    452,
    453,
    454,
    455,
    456,
    457,
    458,
    459,
    460,
    461,
    463,
    464,
    465,
    466,
    467,
    468,
    469,
    470,
    471,
    472,
    473,
    474,
    475,
    476,
    477,
    478,
    479,
    480,
    481,
    483,
    484,
    485,
    486,
    487,
    488,
    489,
    490,
    491,
    492,
    493,
    494,
    495,
    496,
    497,
    498,
    499,
    500,
    501,
    502,
    503,
    504,
    505,
    506,
    507,
    508,
    509,
    510,
    511,
    512,
    513,
    514,
    515,
    516,
    517,
    518,
    519,
    520,
    521,
    522,
    523,
    524,
    525,
    526,
    527,
    528,
    529,
    530,
    531,
    532,
    533,
    534,
    535,
    536,
    537,
    538,
    539,
    540,
    541,
    542,
    543,
    544,
    545,
    546,
    547,
    548,
    549,
    550,
    551,
    552,
    553,
    554,
    555,
    556,
    557,
    558,
    559,
    560,
    561,
    562,
    563,
    564,
    565,
    566,
    567,
    568,
    569,
    570,
    571,
    572,
    573,
    574,
    575,
    576,
    577,
    578,
    579,
    580,
    581,
    582,
    583,
    584,
    585,
    586,
    587,
    588,
    589,
    590,
    591,
    592,
    593,
    594,
    595,
    596,
    597,
    598,
    599,
    600,
    601,
    602,
    603,
    604,
    605,
    606,
    607,
    608,
    609,
    610,
    611,
    612,
    613,
    614,
    615,
    616,
    617,
    618,
    619,
    620,
    621,
    622,
    623,
    624,
    625,
    626,
    627,
    628,
    629,
    630,
    631,
    632,
    633,
    634,
    635,
    636,
    637,
    638,
    639,
    640,
    641,
    642,
    643,
    644,
    645,
    646,
    647,
    648,
    649,
    650,
    651,
    652,
    653,
    654,
    655,
    656,
    657,
    658,
    659,
    660,
    661,
    662,
    663,
    664,
    665,
    666,
    667,
    668,
    669,
];
let numberOfPages = getNumberOfPages(BLIPIDS);

$(function() {
    window.onload = (e) => {
        $("#container").hide();
        window.addEventListener("message", (event) => {
            let data = event.data;
            if (data !== undefined && data.type === "ui") {
                if (data.display === true) {
                    console.log("yeeter");
                    $("#container").show();
                    firstPage();
                } else {
                    $("#container").hide();
                }
            }
        });
    }

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post("http://hackee-playerpoint/closeHUD", JSON.stringify({}));
        }
    };

    $("#first").click(function () {
        firstPage();
    });

    $("#next").click(function () {
        nextPage();
    });

    $("#previous").click(function () {
        previousPage();
    });

    $("#last").click(function () {
        lastPage();
    });

    $("#quitButton").click(closehud);
});

function closehud() {
    $.post("http://hackee-playerpoint/closeHUD", JSON.stringify({}));
}

function resetButtons(){
    $(".buttonscontainer").html("");
    let blipButtons = "<button class='btn blueButton' id='first' onclick=firstPage()>First</button><button class='btn blueButton' id='next' onclick=nextPage()>Next</button><button class='btn blueButton' id='previous' onclick=previousPage()>Previous</button><button class='btn blueButton' id='last' onclick=lastPage()>Last</button><button class='btn blueButton' id='quitButton' onclick=closehud()>Quit</button>";
    $(".buttonscontainer").html(blipButtons);
}

function getNumberOfPages(list) {
    const MAX_PER_PAGE = 15;
    return Math.ceil(BLIPIDS.length / MAX_PER_PAGE);
}

function nextPage() {
    currentPage += 1;
    loadList();
}

function previousPage() {
    currentPage -= 1;
    loadList();
}

function firstPage() {
    resetButtons();
    currentPage = 1;
    loadList();
}

function lastPage() {
    currentPage = numberOfPages;
    loadList();
}

function check() {
    document.getElementById("next").disabled = currentPage == numberOfPages ? true : false;
    document.getElementById("previous").disabled = currentPage == 1 ? true : false;
}

function loadList() {
    $(".blips").html("");
    state.blipId = null;
    var begin = ((currentPage - 1) * numberPerPage);
    var end = begin + numberPerPage;

    pageList = BLIPIDS.slice(begin, end);
    drawList();
    check();
}

function drawList() {
    pageList.forEach( function(item, index) {
        var blipHtml = "<div id='blip"+ item +"' class='blip'><img src='./img/" + item + ".png' alt='"+item+"'></div>";
        $(".blips").append(blipHtml)
        $("#blip"+item).click("click", (event) => {
            state.blipId = event.target.alt;
            openNameInput();
        });
    })
}

function getInputValue(){
    // Selecting the input element and get its value 
    var inputVal = document.getElementById("blipName").value;
    $.post("http://hackee-playerpoint/createPoint", JSON.stringify({
        'blipId': state.blipId,
        'blipName': inputVal
    }));

    closehud();
}

function openNameInput() {
    // clear blip html
    $(".blips").html("")
    // remove buttons
    $(".buttonscontainer").html("")
    // add back button + quit button
    var buttonHtml = "<button class='btn blueButton' id='quitButton' onclick=firstPage()>Back</button><button class='btn blueButton' id='quitButton' onclick=closehud()>Quit</button>"
    $(".buttonscontainer").html(buttonHtml);
    // add text input
    var blipNameHtml = "<input type='text' placeholder='Blip name...' id='blipName'><button type='button' onclick='getInputValue();'>Submit</button>";
    $(".blips").append(blipNameHtml)
}