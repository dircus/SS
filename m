def ocr_search_image(image_path, search_text):
try:
image = Image.open(image_path)
text = pytesseract.image_to_string(image)
if search_text.lower() in text.lower():
print(f'Found in {image_path}: {text}')
except Exception as e:
print(f"Error processing {image_path}: {str(e)}")

def ocr_search_pdf(pdf_path, search_text):
try:
pages = convert_from_path(pdf_path)
for i, page in enumerate(pages):
text = pytesseract.image_to_string(page)
if search_text.lower() in text.lower():
print(f'Found in {pdf_path}, page {i+1}: {text}')
except Exception as e:
print(f"Error processing {pdf_path}: {str(e)}")

def search_in_directory(directory_path, search_text):
for root, _, files in os.walk(directory_path):
for file in files:
if file.endswith(('.png', '.jpg', '.jpeg', '.tiff', '.bmp')):
ocr_search_image(os.path.join(root, file), search_text)
elif file.endswith('.pdf'):
ocr_search_pdf(os.path.join(root, file), search_text)

if __name__ == "__main__":
directory_path = input("Enter the directory path: ")
search_text = input("Enter the text to search: ")
pytesseract.pytesseract.tesseract_cmd = input("Enter the Tesseract executable path: ")
search_in_directory(directory_path, search_text)
