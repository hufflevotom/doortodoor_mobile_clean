class FoliosExceptions implements Exception {
  const FoliosExceptions(this.message);
  final String message;
}

class GetFoliosException extends FoliosExceptions {
  const GetFoliosException(super.message);
}

class SaveEvidenceException extends FoliosExceptions {
  const SaveEvidenceException(super.message);
}

class SaveJustificationException extends FoliosExceptions {
  const SaveJustificationException(super.message);
}

class SaveReportException extends FoliosExceptions {
  const SaveReportException(super.message);
}

class UpdateImageException extends FoliosExceptions {
  const UpdateImageException(super.message);
}

class UploadImagesException extends FoliosExceptions {
  const UploadImagesException(super.message);
}
