// OldStock-2017 Monolithic Business Logic
// @author: Junior Developer (2017)

// Global Variable Pollution - Anti-pattern
var G_DATA = [];
var G_USER_TOKEN = "";
var G_LAST_SCAN = "";
var G_IMG_CACHE = ""; // Will store huge base64 string

function onLoad() {
    console.log("App Initialized...");

    // Check login
    if (localStorage.getItem("isLoggedIn") !== "true") {
        location.href = "login.html";
        return;
    }

    fetchInventory();
}

// $.ajax with Callback Hell and no proper error handling - Anti-pattern
function fetchInventory() {
    $("#loading-overlay").show();

    $.ajax({
        url: "https://jsonplaceholder.typicode.com/posts", // Mocking API
        method: "GET",
        success: function (response) {
            // Nesting logic deep
            G_DATA = response;

            // Artificial delay to show loading.gif
            setTimeout(function () {
                // Duplicate data to reach 500+ items for performance experiment
                var heavyData = [];
                for (var i = 0; i < 6; i++) {
                    heavyData = heavyData.concat(G_DATA);
                }

                renderList(heavyData);
                $("#loading-overlay").hide();

            }, 1000);
        },
        error: function () {
            alert("통신 실패");
            $("#loading-overlay").hide();
        }
    });
}

// Inefficient DOM Rendering using innerHTML in a loop - Anti-pattern
function renderList(items) {
    var html = "";
    var startTime = new Date().getTime();

    for (var i = 0; i < items.length; i++) {
        // Concatenating giant string
        html += "<div class='list-item' id='item-" + items[i].id + "' onclick='itemDetail(" + items[i].id + ")'>";
        html += "   <div style='font-weight: bold; font-size: 13px;'>" + items[i].title.substring(0, 20) + "...</div>";
        html += "   <div style='font-size: 11px; color: #666;'>SKU: STOCK-" + (1000 + i) + " | QTY: " + Math.floor(Math.random() * 100) + "</div>";
        html += "   <div style='text-align: right;'>";
        html += "       <button class='btn-legacy' style='font-size: 10px; background: #5cb85c; color:white;' onclick='editItem(" + items[i].id + ", event)'>EDIT</button>";
        html += "       <button class='btn-legacy' style='font-size: 10px; background: #d9534f; color:white;' onclick='deleteItem(" + items[i].id + ", event)'>DEL</button>";
        html += "   </div>";
        html += "</div>";
    }

    // Total overwrite causing UI freeze
    $("#list-container").html(html);

    var endTime = new Date().getTime();
    console.log("Rendered " + items.length + " items in " + (endTime - startTime) + "ms");
}

// jQuery :contains() DOM filtering - Anti-pattern
function searchItems() {
    var val = $("#search-input").val().toLowerCase();

    // Directly manipulating DOM for search
    $(".list-item").hide();
    $(".list-item").each(function () {
        if ($(this).text().toLowerCase().indexOf(val) > -1) {
            $(this).show();
        }
    });
}

function itemDetail(id) {
    // Legacy event bubbling issues handled by checking event target in onclick or using stopPropagation
    alert("Item ID: " + id + "\nTitle: " + findItemById(id).title);
}

function findItemById(id) {
    for (var i = 0; i < G_DATA.length; i++) {
        if (G_DATA[i].id == id) return G_DATA[i];
    }
    return null;
}

// Legacy In-place Editing using prompt - Anti-pattern
function editItem(id, event) {
    event.stopPropagation(); // Stop itemDetail from firing

    var item = findItemById(id);
    if (!item) return;

    var newTitle = prompt("Edit Item Title:", item.title);

    if (newTitle !== null && newTitle !== "") {
        $("#loading-overlay").show();

        // Simulate API call
        setTimeout(function () {
            item.title = newTitle;

            // Re-render entire list for a single change (Performance bottleneck)
            renderList(G_DATA);

            $("#loading-overlay").hide();
            alert("Item updated successfully!");
        }, 500);
    }
}

// Legacy Delete with confirm - Anti-pattern
function deleteItem(id, event) {
    event.stopPropagation();

    if (confirm("Are you sure you want to delete item #" + id + "?")) {
        $("#loading-overlay").show();

        // Simulate API call
        setTimeout(function () {
            // Removing from global state
            var filtered = [];
            for (var i = 0; i < G_DATA.length; i++) {
                if (G_DATA[i].id != id) {
                    filtered.push(G_DATA[i]);
                }
            }
            G_DATA = filtered;

            // Re-render entire list
            renderList(G_DATA);

            $("#loading-overlay").hide();
            alert("Item deleted.");
        }, 500);
    }
}

// Actual Cordova Plugin Logic Implementation
function takePhoto() {
    $("#loading-overlay").show();

    // Legacy navigator.camera API (v2.x) - Anti-pattern
    navigator.camera.getPicture(function (imageData) {
        $("#loading-overlay").hide();

        // Storing huge base64 in global variable - Memory Leak!
        G_IMG_CACHE = "data:image/png;base64," + imageData;

        // Direct DOM manipulation to show result
        var imgHtml = "<div style='margin-top:10px; border:2px solid #333;'><small>CAPTURED:</small><br><img src='" + G_IMG_CACHE + "' style='width:100%;'></div>";
        $("#list-container").prepend(imgHtml);

        alert("Photo captured and stored in G_IMG_CACHE!");
    }, function (err) {
        $("#loading-overlay").hide();
        alert("Camera Error: " + err);
    }, {
        quality: 50,
        destinationType: Camera.DestinationType.DATA_URL
    });
}

function scanBarcode() {
    // Legacy phonegap-plugin-barcodescanner API (v2.x)
    cordova.plugins.barcodeScanner.scan(
        function (result) {
            if (!result.cancelled) {
                G_LAST_SCAN = result.text;

                // Alert and direct DOM update
                var scanHtml = "<div style='background: yellow; padding: 5px; margin-top:10px; border:1px dashed black;'>SCANNED ID: " + G_LAST_SCAN + "</div>";
                $("#list-container").prepend(scanHtml);

                alert("Scan Result: " + result.text + " (" + result.format + ")");
            }
        },
        function (error) {
            alert("Scanning failed: " + error);
        }
    );
}
