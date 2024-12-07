import Foundation
let HTML1 = """
            <html lang="en">
                <head>
                    <title></title>
                    <meta name="viewport" content="width=device-width, initial-scale=1"/>    
                    
                </head>
                <body>
                <!-- © Seatmap.pro -->
                        <!-- https://seatmap.pro -->
                        <div id="root"></div>
                                   <script src="https://booking.seatmap.pro/static/seatmap-booking-renderer.js"></script>
                                                               <div class="zoom-button-list" style="position:fixed;right:20px; bottom:20px;">
                                                                 <div class="zoom-button" onclick="seatmapRenderer.zoomIn()" style="font-size:30px; background-color:#ffffff; padding:8px; border-radius: 5px; margin-bottom:5px;">+</div>
                                                                 <div class="zoom-button" onclick="seatmapRenderer.zoomOut()" style="font-size:30px; background-color:#ffffff; padding:8px; border-radius: 5px;">–</div>
                                                               </div> 
                                   <script>
                var el = document.getElementById('root');

            var settings = {
              publicKey: '%workSpacekey%',%configAsJs%
            };

            var renderer = (window.seatmapRenderer = new SeatmapBookingRenderer(el, settings));
            var eventId = '%eventID%';
            renderer
              .loadEvent(eventId)
              .zoomToFit()
              .then(function () {
                // After loading the event
                  console.log('Prices', renderer.getPrices());
              });
                </script>
             </body>
             </html>
            """
