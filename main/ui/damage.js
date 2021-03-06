function loadImages() {
    var imageArray = new Array("/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2010/04/10/20100410-_SAK5555_HDR-Edit.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2010/04/18/20100418-_SAK5741-Edit.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2010/05/08/20100508-_SAK5969-Edit.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2010/05/08/20100508-_SAK6007-Edit-Edit.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2007/10/13/DSC_5862-Edit-Edit-1.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2007/11/20/DSC_6488-Edit-2.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2007/12/12/DSC_6772-Edit.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2009/12/25/_SAK3029-Edit-Edit.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2005/05/07/Stanford021-1-Edit-Edit.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2005/11/24/DSC_0093-Edit.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2010/08/23/DSC_9762-Edit.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2010/09/12/DSC_0137-Edit.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2010/09/12/DSC_0097-Edit.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2011/01/16/DSC_3939-Edit.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2011/02/20/DSC_4033-Edit.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2011/03/19/DSC_4476-Edit-Edit.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2011/03/19/DSC_5051-Edit.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2011/05/30/DSC_5655-Edit.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2012/04/30/20120430-DSC_1319.NEF.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2012/04/30/20120430-DSC_1325.NEF.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2012/04/30/20120430-DSC_1320.NEF.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2006/02/16/DSC_1849-Edit-Edit.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2006/09/16/DSC_6872-Edit.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2007/03/13/DSC_1170-Edit.jpg.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2007/06/30/DSC_3744-Edit.jpg.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2007/07/06/DSC_4682-Edit.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2004/09/20/DURIAN-Edit.tif.png",
                                "/Volumes/Data/Data/damage/thumbnails/Volumes/Pictures/2009/12/25/_SAK3029-Edit-Edit.tif.png");
    var str = '';
    imageArray.forEach(function(image){
      str += '<div class="col-lg-3 col-md-4 col-6">';
      str += '<a href="#" class="d-block mb-4 h-100">';
      str += '<img class="img-fluid img-thumbnail" src="';
      str += image
      str += '" alt="">';
      str += '</a>';
      str += '</div>';
    });
    document.getElementById('images').innerHTML = str;        
}