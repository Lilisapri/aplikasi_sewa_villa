<?php
if(isset($_GET['id']) && $_GET['id'] > 0){
    $qry = $conn->query("SELECT * from `room_list` where id = '{$_GET['id']}' ");
    if($qry->num_rows > 0){
        foreach($qry->fetch_assoc() as $k => $v){
            $$k=$v;
        }
    } else {
        // Handle case where no results are found
        $room = $description = $price = $status = null; // Initialize variables to avoid undefined variable notices
    }
}
?>
<div class="card card-outline card-info">
    <div class="card-header">
        <h3 class="card-title"><?php echo isset($id) ? "Update ": "Create New " ?> Homestay</h3>
    </div>
    <div class="card-body">
        <form action="" id="room-form">
            <input type="hidden" name ="id" value="<?php echo isset($id) ? $id : '' ?>">
            <div class="form-group">
                <label for="room" class="control-label">Nama Homestay</label>
                <textarea name="room" id="" cols="30" rows="2" class="form-control form no-resize"><?php echo isset($room) ? $room : ''; ?></textarea>
            </div>
            <div class="form-group">
                <label for="description" class="control-label">Deskripsi</label>
                <textarea name="description" id="" cols="30" rows="2" class="form-control form no-resize summernote"><?php echo isset($description) ? $description : ''; ?></textarea>
            </div>
            <div class="form-group">
                <label for="price" class="control-label">Harga</label>
                <input name="price" id="price" step="any" class="form-control form text-right" value="<?php echo isset($price) ? $price : ''; ?>" min="0">
            </div>
            <div class="form-group">
                <label for="status" class="control-label">Status</label>
                <select name="status" id="status" class="custom-select selevt">
                    <option value="1" <?php echo isset($status) && $status == 1 ? 'selected' : '' ?>>Active</option>
                    <option value="0" <?php echo isset($status) && $status == 0 ? 'selected' : '' ?>>Inactive</option>
                </select>
            </div>
            <div class="form-group">
                <label for="" class="control-label">Images</label>
                <div class="custom-file">
                    <input type="file" class="custom-file-input rounded-circle" id="customFile" name="img[]" multiple accept="image/*" onchange="displayImg(this,$(this))">
                    <label class="custom-file-label" for="customFile">Choose file</label>
                </div>
            </div>
            <?php if(isset($upload_path) && is_dir(base_app.$upload_path)): ?>
            <?php 
                $file= scandir(base_app.$upload_path);
                foreach($file as $img):
                    if(in_array($img,array('.','..')))
                        continue;
                    $img_id_query = $conn->query("SELECT id FROM `room_list` WHERE upload_path = '{$img}'");
                    $img_id = $img_id_query && $img_id_query->num_rows > 0 ? $img_id_query->fetch_assoc()['id'] : null; // Check if query is successful and has results
            ?>
                <div class="d-flex w-100 align-items-center img-item">
                    <span><img src="<?php echo base_url.$upload_path.'/'.$img ?>" width="150px" height="100px" style="object-fit:cover;" class="img-thumbnail" alt=""></span>
                    <span class="ml-4">
                        <button class="btn btn-sm btn-default text-danger rem_img" type="button" data-id="<?php echo $img_id; ?>" data-path="<?php echo base_app.$upload_path.'/'.$img ?>">
                            <i class="fa fa-trash"></i>
                        </button>
                    </span>
                </div>
            <?php endforeach; ?>
            <?php endif; ?>
        </form>
    </div>
    <div class="card-footer">
        <button class="btn btn-flat btn-primary" form="room-form">Simpan</button>
        <a class="btn btn-flat btn-default" href="?page=responses">Batal</a>
    </div>
</div>
<script>
    function displayImg(input,_this) {
        console.log(input.files)
        var fnames = []
        Object.keys(input.files).map(k=>{
            fnames.push(input.files[k].name)
        })
        _this.siblings('.custom-file-label').html(JSON.stringify(fnames))
    }
    
    function delete_room(path, id){ // Mengubah nama fungsi menjadi delete_room
        start_loader()
        
        $.ajax({ 
            url: _base_url_+'classes/Master.php?f=delete_p_img',
            data:{path:path, id: id}, // Mengirimkan ID gambar
            method:'POST',
            dataType:"json",
            error:err=>{
                console.log(err)
                alert_toast("An error occurred while deleting an Image","error");
                end_loader()
            },
            success:function(resp){
                $('.modal').modal('hide')
                if(typeof resp =='object' && resp.status == 'success'){
                    // Perbaikan: Pastikan ID gambar yang benar dihapus
                    $('[data-id="'+id+'"]').closest('.img-item').hide('slow',function(){
                        $('[data-id="'+id+'"]').closest('.img-item').remove()
                    })
                    alert_toast("Image Successfully Deleted","success");
                }else{
                    console.log(resp)
                    alert_toast("An error occurred while deleting an Image","error");
                }
                end_loader()
            }
        })
    }

    $(document).ready(function(){
        $('.rem_img').click(function(){
            var imgId = $(this).attr('data-id'); // Ambil ID gambar
            var imgPath = $(this).attr('data-path'); // Ambil jalur gambar
            _conf("Are you sure to delete this image permanently?", 'delete_room', [imgPath, imgId]) // Mengubah fungsi yang dipanggil menjadi delete_room
        })
        $('#room-form').submit(function(e){
            e.preventDefault();
            $('.err-msg').remove();
            start_loader();
            $.ajax({
                url:_base_url_+"classes/Master.php?f=save_room",
                data: new FormData($(this)[0]),
                cache: false,
                contentType: false,
                processData: false,
                method: 'POST',
                type: 'POST',
                dataType: 'json',
                error:err=>{
                    console.log(err)
                    alert_toast("An error occurred",'error');
                    end_loader();
                },
                success:function(resp){
                    if(typeof resp =='object' && resp.status == 'success'){
                        location.href = "./?page=room";
                    }else{
                        alert_toast("An error occurred",'error');
                        end_loader();
                        console.log(resp)
                    }
                }
            })
        })

        $('.summernote').summernote({
            height: 200,
            toolbar: [
                [ 'style', [ 'style' ] ],
                [ 'font', [ 'bold', 'italic', 'underline', 'strikethrough', 'superscript', 'subscript', 'clear'] ],
                [ 'fontname', [ 'fontname' ] ],
                [ 'fontsize', [ 'fontsize' ] ],
                [ 'color', [ 'color' ] ],
                [ 'para', [ 'ol', 'ul', 'paragraph', 'height' ] ],
                [ 'table', [ 'table' ] ],
                [ 'view', [ 'undo', 'redo', 'fullscreen', 'codeview', 'help' ] ]
            ]
        })
    })
</script>