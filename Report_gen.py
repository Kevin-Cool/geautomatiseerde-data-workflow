
def combined():
    file = "air quality"
    titel = "Analysis of the air quality"
    intro = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    left_image = "../analysedata/combined.png"
    right_text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Congue quisque egestas diam in arcu cursus euismod quis. Id nibh tortor id aliquet lectus. Velit sed ullamcorper morbi tincidunt ornare massa eget. Molestie a iaculis at erat pellentesque adipiscing. Lectus arcu bibendum at varius vel pharetra vel. Vitae sapien pellentesque habitant morbi tristique senectus et netus et. Ipsum dolor sit amet consectetur adipiscing elit ut aliquam. Commodo odio aenean sed adipiscing diam donec adipiscing tristique. Lorem sed risus ultricies tristique nulla. Elementum nibh tellus molestie nunc. </br> </br> Sem integer vitae justo eget magna fermentum iaculis eu non. Ornare aenean euismod elementum nisi quis eleifend quam adipiscing. Habitant morbi tristique senectus et netus et malesuada fames. Nisi est sit amet facilisis magna. Fermentum odio eu feugiat pretium nibh ipsum consequat nisl. Nisl vel pretium lectus quam id leo in. Venenatis urna cursus eget nunc scelerisque. Aliquam vestibulum morbi blandit cursus risus. Habitant morbi tristique senectus et netus. Turpis egestas integer eget aliquet nibh praesent tristique magna sit. Quis imperdiet massa tincidunt nunc pulvinar sapien et ligula ullamcorper. Bibendum neque egestas congue quisque egestas. Porta lorem mollis aliquam ut porttitor leo. Nisl condimentum id venenatis a. Amet venenatis urna cursus eget nunc. Est sit amet facilisis magna etiam tempor orci eu. Porta lorem mollis aliquam ut porttitor leo a. Mauris in aliquam sem fringilla. Neque viverra justo nec ultrices dui sapien eget."
    
    template(file,titel,intro,left_image,right_text)

def separate():
    file = "air quality difference"
    titel = "Analysis of the air quality difference between inside and outside"
    intro = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    left_image = "../analysedata/separate.png"
    right_text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Congue quisque egestas diam in arcu cursus euismod quis. Id nibh tortor id aliquet lectus. Velit sed ullamcorper morbi tincidunt ornare massa eget. Molestie a iaculis at erat pellentesque adipiscing. Lectus arcu bibendum at varius vel pharetra vel. Vitae sapien pellentesque habitant morbi tristique senectus et netus et. Ipsum dolor sit amet consectetur adipiscing elit ut aliquam. Commodo odio aenean sed adipiscing diam donec adipiscing tristique. Lorem sed risus ultricies tristique nulla. Elementum nibh tellus molestie nunc. </br> </br> Sem integer vitae justo eget magna fermentum iaculis eu non. Ornare aenean euismod elementum nisi quis eleifend quam adipiscing. Habitant morbi tristique senectus et netus et malesuada fames. Nisi est sit amet facilisis magna. Fermentum odio eu feugiat pretium nibh ipsum consequat nisl. Nisl vel pretium lectus quam id leo in. Venenatis urna cursus eget nunc scelerisque. Aliquam vestibulum morbi blandit cursus risus. Habitant morbi tristique senectus et netus. Turpis egestas integer eget aliquet nibh praesent tristique magna sit. Quis imperdiet massa tincidunt nunc pulvinar sapien et ligula ullamcorper. Bibendum neque egestas congue quisque egestas. Porta lorem mollis aliquam ut porttitor leo. Nisl condimentum id venenatis a. Amet venenatis urna cursus eget nunc. Est sit amet facilisis magna etiam tempor orci eu. Porta lorem mollis aliquam ut porttitor leo a. Mauris in aliquam sem fringilla. Neque viverra justo nec ultrices dui sapien eget."
    
    template(file,titel,intro,left_image,right_text)
        
def template(file,titel,intro,left_image,right_text):
    with  open(f"generatedreports/{file}.md", "w") as md:
        md.write(f'# {titel}\n')
        md.write(f'{intro}\n')
        md.write(f' <img src="{left_image}" alt="left graph" style="width:100%"> \n')
        md.write(f'{right_text} ')
        
             
if __name__ == "__main__":
    combined()
    separate()